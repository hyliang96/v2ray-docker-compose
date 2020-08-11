

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."


. "$here/metaconfig.sh"

certbot_path="$repo_root/certbot"
# domain="$1"

if [ -f $certbot_path/certbot-etc/live/$domain/$domain.pem ]; then
    echo "已有证书: $certbot_path/certbot-etc/live/$domain/$domain.pem"
    exit
fi

cd "$certbot_path"

if [ $(docker-compose ps | wc -l) -gt 2 ]; then
    docker-compose down
    docker system prune -af
fi

echo
echo "docker-compose 启动"
echo "当返回 'certbot_cerbot_1 exited with code x=0,1,2...' 时, 按 CTRL+C 退出 docker-compose "
echo "x=0, 表示证书生成成功; x≠0, 表示证书生成失败"
echo

docker-compose up --exit-code-from cerbot
# --abort-on-container-  exit
err_code="$?"

docker-compose down
docker system prune -af

sudo chown -R $USER:$USER $certbot_path

cat $certbot_path/certbot-etc/live/$domain/fullchain.pem > $certbot_path/certbot-etc/live/$domain/$domain.pem
cat $certbot_path/certbot-etc/live/$domain/privkey.pem >> $certbot_path/certbot-etc/live/$domain/$domain.pem

exit $err_code
