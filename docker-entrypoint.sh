#!/bin/bash
set -e

if [ "$1" = 'redis-server' ]; then
        chown -R redis .
        #exec gosu redis "$@"
        exec sudo redis -c "$@"
fi

exec "$@"
