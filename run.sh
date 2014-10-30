#!/bin/bash

/etc/init.d/asterisk start
sleep 1
rasterisk -cgvvv
