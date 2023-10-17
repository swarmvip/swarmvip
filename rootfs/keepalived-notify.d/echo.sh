#!/bin/bash

# for ANY state transition.
# "notify" script is called AFTER the
# notify_* script(s) and is executed
# with 3 arguments provided by keepalived
# (ie don't include parameters in the notify line).
# arguments
# $1 = "GROUP"|"INSTANCE"
# $2 = name of group or instance
# $3 = target state of transition
#     ("MASTER"|"BACKUP"|"FAULT")

# TYPE=$1
# NAME=$2
STATE=$3

case $STATE in
    "MASTER") echo "[ACK] Node is now MASTER!." > /proc/1/fd/1
        exit 0
    ;;
    "BACKUP") echo "[ACK] Node is now A BACKUP" > /proc/1/fd/1
        exit 0
    ;;
    "FAULT")  echo "[ACK] Received status \"FAULT\", something went wrongs!" > /proc/1/fd/1
        exit 0
    ;;
    *)        echo "[ACK] Unknown state" > /proc/1/fd/1
        exit 1
    ;;
esac
