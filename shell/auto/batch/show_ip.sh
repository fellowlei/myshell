#!/bin/sh
ifconfig | grep 'inet addr' | grep -v '127.0.0.1'\r
sleep 2
ifconfig | grep 'inet addr' | grep -v '127.0.0.1'\r
