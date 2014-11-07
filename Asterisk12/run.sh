#!/bin/bash

/etc/init.d/asterisk start
sleep 1
rasterisk -cgvvv

echo "asterisk-docker: disconnected. Waiting for Asterisk to shut down."
sleep 2
