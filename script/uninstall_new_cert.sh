
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."
. "$here/metaconfig.sh"
certbot_etc_path="$repo_root/certbot/certbot-etc"


if [ -f ${certbot_etc_path}/live/$domain/$domain.pem ]; then
    echo "已有证书: ${certbot_etc_path}/live/$domain/$domain.pem"
    while true; do
        answer=$(bash -c "read -n 1 -p '删除已有证书? Y/N (默认N) ' c; echo \$c"); echo
        [ "$answer" = '' ]  &&  answer='N'
        [[ "$answer" =~ ^[Yy]$  ]] && break
        [[ "$answer" =~ ^[Nn]$  ]] && exit
        echo "请输入Y或N"
    done
fi

if [ -d ${certbot_etc_path} ]; then
    sudo rm -rf ${certbot_etc_path}
    mkdir ${certbot_etc_path}
    touch ${certbot_etc_path}/certs_will_appear
fi