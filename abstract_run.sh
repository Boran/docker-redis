#!/bin/bash
set -e

PATH=${PATH}:/usr/local/bin

# includes
#. /data/service/functions.sh

# ENV handler
if [[ $REDIS_ROLE = "" ]]; then REDIS_ROLE="singlenode"; fi

if [[ $REDIS_ROLE = "singlenode" ]]; then
        SERVICE_NAME="Redis_Single_Node"

        if [[ $CONTAINERNAME = "" ]]; then CONTAINERNAME="default"; fi

fi

echo "$0 : Start abstract_run.sh..."


if [[ $REDIS_ROLE = "singlenode" ]]; then
        chown -R redis .
        # run wig gosu or sudolater
        #exec gosu redis "$@"
        #exec sudo redis -c "$@"
        echo "$0 : start redis-server service for perm. running"
        echo  "redis-server --port ${REDIS_PORT}"
        exec redis-server --port ${REDIS_PORT}

# else, later run slave nodes, e.g. --slaveof 127.0.0.1 6379

fi
