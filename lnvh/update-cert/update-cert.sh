#!/bin/bash
# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
cd $(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)

DOMAIN="example.com"

CERT_HOME="../certbot-etc/live/$DOMAIN"
COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"

$COMPOSE run certbot renew

cat $CERT_HOME/fullchain.pem > $CERT_HOME/$DOMAIN.pem
cat $CERT_HOME/privkey.pem >> $CERT_HOME/$DOMAIN.pem
#cat $CERT_HOME/fullchain.pem $CERT_HOME/privkey.pem | tee $CERT_HOME/gcptw3.hyliang.ml.pem

# SIGHUP: 重新读取配置文件
$COMPOSE kill -s SIGHUP haproxy

# 清理过没在运行的容器
$DOCKER system prune -af
