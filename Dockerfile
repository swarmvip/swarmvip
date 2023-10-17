FROM alpine:latest

RUN apk update && apk add --no-cache \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# https://github.com/socheatsok78/s6-overlay-installer
ARG S6_OVERLAY_VERSION=v3.1.5.0
ARG S6_OVERLAY_INSTALLER=main/s6-overlay-installer.sh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/socheatsok78/s6-overlay-installer/${S6_OVERLAY_INSTALLER})"
ENTRYPOINT [ "/init" ]
CMD [ "sleep", "infinity" ]

ARG TARGETARCH
ADD https://github.com/hairyhenderson/gomplate/releases/download/v3.11.5/gomplate_linux-${TARGETARCH} /usr/local/bin/gomplate

RUN apk update && apk add --no-cache \
        keepalived \
    && rm -rf /var/cache/apk/*

# Docker Swarm specific environment variables
ENV TASK_SLOT=

ENV KEEPALIVED_CONFIG_FILE=/etc/keepalived/keepalived.conf
ENV KEEPALIVED_ARGS=

ENV KEEPALIVED_INTERFACE=eth0
ENV KEEPALIVED_STATE=MASTER
ENV KEEPALIVED_ROUTER_ID=51
ENV KEEPALIVED_PRIORITY=150
ENV KEEPALIVED_PASSWORD=dockerswarm
