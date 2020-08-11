here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

. "$here/metaconfig.sh"

scheme_root="$repo_root/$scheme"
cd "$scheme_root"


log_list=(
    "docker-compose-log"
    "$scheme_root/v2ray/log/access.log"
    "$scheme_root/v2ray/log/error.log"
    "$scheme_root/nginx/log/access.log"
    "$scheme_root/nginx/log/error.log"
    "$repo_root/certbot/nginx/log/access.log"
    "$repo_root/certbot/nginx/log/error.log"
)

log_prompt_list=(
    '服务端 docker-compose 的 log'
    '服务端 v2ray access log'
    '服务端 v2ray error log'
    '服务端 nginx access log'
    '服务端 nginx error log'
    '新申请证书 nginx access log'
    '新申请证书 nginx error log'
    '退出查看 log'
)

end_index=$(( ${#log_prompt_list[@]} - 1))
end_index_minux_1=$(( ${end_index} - 1 ))

while true; do
    echo
    for ((i=0; i<=${end_index}; i++ )); do
        echo "[$i] ${log_prompt_list[$i]}"
    done

    index=$(bash -c "read -n 1 -p '选择log的编号? [0-${end_index}] ' c; echo \$c"); echo
    if [ "${log_list[$index]}" = 'docker-compose-log' ]; then
        cd "$scheme_root"
        docker-compose logs -t -f
    elif [[ "$index" =~ ^[0-${end_index_minux_1}]$ ]]; then
        echo "less ${log_list[$index]}"
        less "${log_list[$index]}"
    elif [ "$index" = "${end_index}" ]; then
        break
    else
        echo "请输入 0-${end_index}"
    fi
done

