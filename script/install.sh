#!/usr/bin/env bash

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)

bash "$here/config_gen.sh"
bash "$here/run_docker_new_cert.sh" "$domain"
[ "$?" != 0 ] && exit

bash "$here/install_update_cert.sh"
bash "$here/run_docker_v2ray.sh"

# release this variable in the end of file
unset -v here

