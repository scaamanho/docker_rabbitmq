#!/bin/bash

set -m

if [ ! -f /.rabbitmq_password_set ]; then
	/set_rabbitmq_password.sh
fi

# make rabbit own its own files
chown -R rabbitmq:rabbitmq /var/lib/rabbitmq

if [ -z "$CLUSTER_WITH" ] ; then
    /usr/sbin/rabbitmq-server &
    if [ ! -f /.config_set ]; then
        sleep 10
	   /load_config.sh
    fi
    fg
else
    if [ -f /.CLUSTERED ] ; then
    /usr/sbin/rabbitmq-server
    else
        touch /.CLUSTERED
        /usr/sbin/rabbitmq-server &
        sleep 10
        if [ ! -f /.config_set ]; then
           /load_config.sh
        fi
        rabbitmqctl stop_app
        rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
        rabbitmqctl start_app
        fg
    fi
fi
