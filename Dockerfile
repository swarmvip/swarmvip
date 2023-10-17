FROM alpine:latest

RUN apk update && apk add --no-cache \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.5.0
ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"
ENV S6_KEEP_ENV=1
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]

ARG TARGETARCH
ADD https://github.com/hairyhenderson/gomplate/releases/download/v3.11.5/gomplate_linux-${TARGETARCH} /usr/local/bin/gomplate
RUN chmod +x /usr/local/bin/gomplate

RUN apk update && apk add --no-cache \
        ipset \
        iptables \
        ipvsadm \
        iproute2 \
        libnfnetlink \
        libnl3 \
        keepalived \
    && rm -rf /var/cache/apk/*

# Docker Swarm specific environment variables
ENV TASK_SLOT=

ENV KEEPALIVED_CONFIG_FILE=/etc/keepalived/keepalived.conf
ENV KEEPALIVED_ARGS=

ENV SWARMVIP_INTERFACE=eth0
ENV SWARMVIP_SLOT=1
ENV SWARMVIP_VRID=51
ENV SWARMVIP_TOKEN=dockerswarm
ENV SWARMVIP_INIT_CLUSTER=
ENV SWARMVIP_ADDRESSES=

ADD rootfs /

RUN apk update && apk add --no-cache \
        bind-tools \
    && rm -rf /var/cache/apk/*
