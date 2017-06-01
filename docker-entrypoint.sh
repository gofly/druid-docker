#!/bin/ash
set -ex

if [[ "$1" = "broker" ]] || [[ "$1" = "coordinator" ]] || [[ "$1" = "historical" ]] || [[ "$1" = "middleManager" ]] || [[ "$1" = "overlord" ]]; then
	exec java `cat $CONF_DIR/$1/jvm.config | xargs` -cp /opt/druid/conf/druid/_common:/opt/druid/conf/druid/$1:/opt/druid/lib/* io.druid.cli.Main server $@
fi

exec "$@"
