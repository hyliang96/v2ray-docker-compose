# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)


now_installed=false

if ! command -v docker> /dev/null; then
    while true; do
        answer=$(bash -c "read -n 1 -p '未安装docker, 是否安装? Y/N ' c; echo \$c"); echo
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            $here/install_docker.sh
            now_installed=true
            break
        elif [[ "$answer" =~ ^[Nn]$ ]]; then
            break
        else
            echo '请输入 Y/N'
        fi
    done
fi

if ! command -v docker-compose> /dev/null; then
    while true; do
        answer=$(bash -c "read -n 1 -p '未安装docker-compose, 是否安装? Y/N ' c; echo \$c"); echo
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            $here/install_docker_compose.sh
            now_installed=true
            break
        elif [[ "$answer" =~ ^[Nn]$ ]]; then
            break
        else
            echo '请输入 Y/N'
        fi
    done
fi


# if [ "$now_installed" = true ]; then
#     echo '重新登录终端以使得当前用户有权使用 docker/docker-compose'
# fi
