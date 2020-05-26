#!/bin/bash

# based on https://github.com/beardedio/dcon-terraria, which is
# subject to the MIT License, found in file "MIT" and is Copyright (c)
# Brandon Skrtich

cd /usr/server

TORUN="./TerrariaServerWrapper -config /config/serverconfig.txt -banlist /config/banlist.txt"

if [ ! -f /config/serverconfig.txt ];
then
    cp /usr/server/defaultconfig.txt /config/serverconfig.txt
    echo "Created new default config file"
fi

if [ ! -f /config/banlist.txt ];
then
    touch /config/banlist.txt
    echo "Created empty ban list"
fi

if [ ! -z "$world" ];
then
    if [ ! -f "/worlds/$world" ];
    then
        echo "FATAL: '/worlds/$world' does not exist."
        exit
    fi
    TORUN="$TORUN -world /worlds/$world"
fi

echo "$TORUN $@"
exec $TORUN $@
