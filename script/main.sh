v2docker_dir=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)


v2docker() {
    local prompt_list=(
        '配置或修改配置 v2docker 并启动'
        '启动 v2docker'
        '重启 v2docker'
        '停止 v2docker'
        '查看 log'
    )

    local script_list=(
        "$v2docker_dir/config.sh"
        "$v2docker_dir/start.sh"
        "$v2docker_dir/restart.sh"
        "$v2docker_dir/stop.sh"
        "$v2docker_dir/see_log.sh"
    )

    declare -p prompt_list

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

    # get absoltae path to the dir this is in, work in bash, zsh
    # if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`


    sudo bash "${script_list[@]:${index}:1}"

    # release this variable in the end of file
}