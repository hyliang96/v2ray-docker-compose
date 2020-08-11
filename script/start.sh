

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

. "$here/metaconfig.sh"

scheme_root="$repo_root/$scheme"
cd "$scheme_root"

bash "$here/install_update_cert.sh"

echo
echo "docker-compose 启动"
echo "* 各镜像均返回 'certbot_cerbot_1 exited with code 0' 时"
echo "    则这套v2ray配置启动成功, 关闭终端以退出, 可令docker-compose在后台继续运行 (请勿按CTRL+C)"
echo "* 若有镜像返回 'certbot_cerbot_1 exited with code x' (x非0) 时"
echo "    则该镜像运行出错, 使这套v2ray配置启动失败, 请按 CTRL+C 以退出docker-compose"
echo

docker-compose up


docker-compose down
docker system prune -af


