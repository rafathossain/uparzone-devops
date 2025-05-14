#!/bin/bash

echo "Starting HAProxy and Redis containers..."

mkdir -p /home/haproxy
mkdir -p /home/haproxy/certs
mkdir -p /home/redis

if [ ! -f .env ]; then
    cp .env.example .env
fi

if [ ! -f /home/haproxy/haproxy.cfg ]; then
    cp haproxy.cfg.example /home/haproxy/haproxy.cfg
fi

docker-compose up -d

echo "Updating .env file with REDIS_PASSWORD"
echo "Update HAProxy Config in /home/haproxy/haproxy.cfg and restart container to apply changes."
echo "Set the SSL Certificate in /home/haproxy/certs/uparzone.com.pem. The crt option should point to a combined certificate file that includes both the certificate and the private key in a single .pem file."
