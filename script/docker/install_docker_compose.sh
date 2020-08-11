

set -o errexit
set -o nounset

IFS=$(printf '\n\t')


# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
[ -f /usr/bin/docker-compose ] && sudo rm /usr/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
printf '\ndocker-compose 安装成功\n\n'
docker-compose --version

