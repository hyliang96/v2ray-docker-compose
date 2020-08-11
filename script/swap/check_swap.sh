# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)

if [[ ! $(cat /proc/swaps | wc -l) -gt 1 ]]; then
    echo '交换内存未开启, 建议开启, 以使docker运行顺畅'
    while true; do
        answer=$(bash -c "read -n 1 -p '是否开启交换内存? Y/N ' c; echo \$c"); echo
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            bash $here/set_swap.sh 1 # set swap size = 1GB
            break
        elif [[ "$answer" =~ ^[Nn]$ ]]; then
            break
        else
            echo '请输入 Y/N'
        fi
    done
fi