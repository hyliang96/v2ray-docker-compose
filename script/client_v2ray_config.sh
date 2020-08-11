

here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

if [ -f "$here/metaconfig.sh" ]; then
    . "$here/metaconfig.sh"
else
    echo
    echo "您尚未配置 v2docker"
    exit
fi

echo
echo "-------------------------------------------"
echo "客户端v2ray配置参数:"

if [ "${scheme}" = 'lnvh' ]; then
    echo '服务器设置:'
    echo '    "address": "'${domain}'"'
    echo '    "port": 443'
    cat "${repo_root}/"${scheme}"/v2ray/config.json" | grep -E 'id|alterId' | sed -e 's/^[ ]*/    /'
    echo '    "security": "auto"'

    echo '传输设置:'
    echo '    "network": "tcp"'
    echo '    "security": "tls"'
elif [ "${scheme}" = 'lnv' ]; then
    echo '服务器设置:'
    echo '    "address": "'${domain}'"'
    echo '    "port": 443'
    cat "${repo_root}/"${scheme}"/v2ray/config.json" | grep -E 'id|alterId' | sed -e 's/^[ ]*/    /'
    echo '    "security": "auto"'

    echo '传输设置:'
    cat "${repo_root}/"${scheme}"/v2ray/config.json" | grep -E 'path|network' | sed -e 's/^[ ]*/    /'
    echo '    "security": "tls"'
else
    echo "不支持自动显示 ${scheme} 方案的 v2ray配置, 请自行查看"
    echo "    ${repo_root}/"${scheme}"/v2ray/config.json"
fi

