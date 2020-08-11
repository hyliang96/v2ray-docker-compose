# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)


bash "$here/stop.sh"
bash "$here/start.sh"


# release this variable in the end of file
unset -v here