

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."

. "$here/metaconfig.sh"


# scheme="$1"

# sudo mkdir -p /usr/share/v2ray-docker-compose
# sudo cp "$repo_root/$scheme/update-cert/update-cert.sh" /usr/share/v2ray-docker-compose/
# sudo cp "$repo_root/$scheme/update-cert/update-cert-cron" /etc/cron.d/update-cert-cron
sudo sed -e "s|UPDATE-CERT.SH|$repo_root/$scheme/update-cert/update-cert.sh|g" \
    "$repo_root/$scheme/update-cert/update-cert-cron" | \
    sudo tee /etc/cron.d/update-cert-cron >/dev/null
