#!/bin/bash
set -e

PATH=${PATH}:/usr/local/bin

if [ "$1" = 'redis-server' ]; then
        chown -R redis .
        # run wig gosu or sudolater
        #exec gosu redis "$@"
        #exec sudo redis -c "$@"
        exec "$@"
fi

exec "$@"
