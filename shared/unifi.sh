#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=unifi
QPKG_DISPLAY_NAME=$(/sbin/getcfg $QPKG_NAME Display_Name -f $QPKG_CONF)
QPKG_DIR=$(/sbin/getcfg $QPKG_NAME Install_Path -f $QPKG_CONF)
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)
DOCKER=$(/sbin/getcfg $QPKG_NAME Docker_Cmd -d "system-docker" -f $QPKG_CONF)

# source qpkg/dqpkg functions
QTS_LOG_TAG="$QPKG_DISPLAY_NAME"
. $CONTAINER_STATION_DIR/script/qpkg-functions
. $CONTAINER_STATION_DIR/script/dqpkg-functions

# main
case "$1" in
  start)
    if ! qts_qpkg_is_enabled $QPKG_NAME; then
        qts_error_exit "$QPKG_DISPLAY_NAME is disabled."
    fi
    wait_qcs_ready
    qbus_cmd start
    complete_action "configure installing installed starting running stopping stopped" 120
    ;;

  stop)
    qbus_cmd stop
    complete_action "removed stopped" 30
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    qbus_cmd remove
    complete_action "removed" 60
    ;;

  pre-configure)
    ./pre-configure.py
    ;;

  check-health)
    web_container_id=`sh compose ps -q unifi`
    ipv4addr=`$DOCKER inspect --format='{{.NetworkSettings.Networks.unifi_unifi.IPAddress}}' $web_container_id`
    if curl -ksq http://${ipv4addr}:8080/ > /dev/null; then
        sed "s/{{IPV4ADDR}}/${ipv4addr}/" unifi.apache.conf.tpl > unifi.apache.conf
        exit 0
    fi
    exit 1
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
