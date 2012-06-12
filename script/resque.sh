#!/bin/bash

PIDFILE=./tmp/pids/resque.pid BACKGROUND=yes VVERBOSE=1 QUEUE=dependency_fetcher rake resque:work > ./log/resque.log 2>&1 &
