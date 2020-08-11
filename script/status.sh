here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

if [ -f "$here/metaconfig.sh" ]; then
    . "$here/metaconfig.sh"
    scheme_root="$repo_root/$scheme"
    cd "$scheme_root"
    if [ $(docker-compose ps | wc -l) -gt 2 ]; then
        echo "v2docker 正在运行"
    else
        echo "v2docker 未在运行"
    fi
else
    echo "v2docker 尚未配置, 请配置 v2docker"
fi
echo