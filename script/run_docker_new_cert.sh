

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

certbot_path="$repo_root/certbot"
domain="$1"

cd "$certbot_path"

echo "docker-compose 启动"
echo "当返回 'certbot_cerbot_1 exited with code x=0,1,2...' 时, 按 CTRL+C 退出 docker-compose "
echo "x=0, 表示证书生成成功; x≠0, 表示证书生成失败"

docker-compose up --exit-code-from cerbot
# --abort-on-container-  exit
err_code="$?"

docker-compose down

sudo chown -R $USER:$USER $certbot_path

cat $certbot_path/certbot-etc/live/$domain/fullchain.pem > $certbot_path/certbot-etc/live/$domain/$domain.pem
cat $certbot_path/certbot-etc/live/$domain/privkey.pem >> $certbot_path/certbot-etc/live/$domain/$domain.pem

echo $err_code
