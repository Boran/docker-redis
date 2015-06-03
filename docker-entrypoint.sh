#!/bin/bash
set -e

PATH=${PATH}:/usr/local/bin

if [ "$1" = 'redis-server' ]; then
        chown -R redis .
        # run with gosu or sudo later
        #exec gosu redis "$@"
        #exec sudo redis -c "$@"
        exec "$@"
fi

exec "$@"
