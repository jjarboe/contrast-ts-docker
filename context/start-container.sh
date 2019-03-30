#!/bin/sh

/etc/init.d/contrast-server start
sleep 10
tail -f /usr/local/contrast/data/logs/contrast.log -f /usr/local/contrast/logs/server.log
sleep 100
