# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

. "$here/metaconfig.sh"

scheme_root="$repo_root/$scheme"
cd "$scheme_root"

if [ $(docker-compose ps | wc -l) -gt 2 ]; then
    docker-compose down
    docker system prune -af
    bash "$here/uninstall_update_cert.sh"
fi

