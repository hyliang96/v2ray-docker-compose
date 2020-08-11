#!/bin/sh

set -o errexit
set -o nounset

IFS=$(printf '\n\t')


# Docker
sudo apt-get remove --yes docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install --yes --no-install-recommends apt-transport-https ca-certificates \
                                            curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install --yes --no-install-recommends docker-ce docker-ce-cli containerd.io
! [ $(getent group docker) ] && sudo groupadd docker
sudo usermod --append --groups docker "$USER"
newgrp docker
sudo systemctl enable docker

printf '\ndocker 安装成功\n\n'
printf '等 docker服务 启动...\n\n'
sleep 5

