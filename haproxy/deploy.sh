#!/bin/bash

mkdir -p /home/haproxy
mkdir -p /home/haproxy/certs
mkdir -p /home/redis

cp .env.example .env

docker-compose up -d

echo "Updating .env file with REDIS_PASSWORD"
echo "Set the SSL Certificate in /home/haproxy/certs/uparzone.com.pem"
echo "Set the SSL Certificate Key in /home/haproxy/certs/uparzone.com.pem.key"
