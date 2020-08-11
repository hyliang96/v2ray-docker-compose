v2docker_dir=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)


v2docker() {
    bash "$v2docker_dir/swap/check_swap.sh"
    bash "$v2docker_dir/docker/check_docker.sh"
    bash "$v2docker_dir/status.sh"

    local prompt_list=(
        '配置或修改配置 v2docker 并启动'
        '启动/重启 v2docker'
        '停止 v2docker'
        '查看 log'
    )

    local script_list=(
        "$v2docker_dir/config.sh"
        "$v2docker_dir/start.sh"
        "$v2docker_dir/stop.sh"
        "$v2docker_dir/see_log.sh"
    )

    local end_index=$(( ${#prompt_list[@]} - 1))

    while true; do
        for ((i=0; i<=${end_index}; i++ )); do
            echo "[$i] ${prompt_list[@]:$i:1}"
        done

        local index=$(bash -c "read -n 1 -p '选择操作? [0-${end_index}] ' c; echo \$c"); echo
        [[ $index =~ ^[0-${end_index}]$ ]]  && break
        echo "请输入 0-${end_index}"
        echo
    done
    echo

    sudo bash "${script_list[@]:${index}:1}"
}