#!/bin/sh

sed -i '/bind 127.0.0.1/d' /etc/redis.conf
sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis.conf
sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf

redis-server --protected-mode no
