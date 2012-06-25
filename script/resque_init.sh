#!/bin/bash
redis-cli -h localhost -n 0 hset services resque '["localhost"]'
