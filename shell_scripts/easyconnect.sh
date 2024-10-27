#!/bin/bash

#docker run \
#  --device /dev/net/tun \
#  --cap-add NET_ADMIN \
#  -ti \
#  --net=host \
#  -p 127.0.0.1:1080:1080 \
#  -p 127.0.0.1:8888:8888 \
#  -e EC_VER=7.6.8 \
#  -e CLI_OPTS="-d https://vpn.nwpu.edu.cn -u 2018200101 -p sbw1995124" \
#  hagb/docker-easyconnect:cli

docker run --rm --device /dev/net/tun --cap-add NET_ADMIN -ti -p 127.0.0.1:1080:1080 -p 127.0.0.1:8888:8888 -e EC_VER=7.6.8 -e CLI_OPTS="-d https://vpn.nwpu.edu.cn -u 2018200101 -p sbw1995124" hagb/docker-easyconnect:cli
