#!/bin/bash

mkdir -p /home/haproxy
mkdir -p /home/haproxy/certs
mkdir -p /home/redis

docker-compose up -d