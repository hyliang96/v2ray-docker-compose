
# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)


if [ -f "$here/metaconfig.sh" ]; then
    . "$here/metaconfig.sh"
else
    scheme=0
    email=someone@example.com
    domain=somesite.example.com
    UUID="$(cat /proc/sys/kernel/random/uuid)"
    v2ray_path='/'
fi

echo
echo "方案:"
echo "[0] tcp + tls (nginx, haproxy)"
echo "[1] websocket + tls (nginx)"
echo "[2] trojan"

scheme_list=(
    "lnvh"
    "lnv"
    "lnv_trojan"
)

scheme_index=0
for i in {0..2}; do
    [ "${scheme_list[$i]}" = "$scheme" ] && scheme_index=$i && break
done

while true; do
    new_scheme_index=$(bash -c "read -n 1 -p '选择方案(默认当前 $scheme_index): ' c; echo \$c"); echo
    [ "$new_scheme_index" = '' ] && new_scheme_index="$scheme_index"
    if [[ "$new_scheme_index" =~ ^[0-2]$ ]]; then
        new_scheme="${scheme_list[$new_scheme_index]}"
        # while true; do
        #     answer=$(bash -c "read  -n 1 -p '确认方案: $scheme ? [Y|N]' c; echo \$c"); echo
        #     [[ "$answer" =~ ^[YyNn]$ ]] && break
        # done
        # [[ "$answer" =~ ^[Yy]$ ]] && break
        break
    else
        echo '请输入正确的方案编号'
    fi
done
scheme="$new_scheme"
echo




while true; do
    new_domain=$(bash -c "read -p '域名(默认当前 $domain): ' c; echo \$c")
    [ "$new_domain" = '' ] && new_domain="$domain" && break
    if [[ "$new_domain" =~ ^[a-zA-Z0-9][\-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][\-a-zA-Z0-9]{0,62})+$ && "$new_domain" =~ ^.{3,255}$ ]]; then
        # while true; do
        #     answer=$(bash -c "read  -n 1 -p '确认域名: $new_domain ? [Y|N]' c; echo \$c"); echo
        #     [[ "$answer" =~ ^[YyNn]$ ]] && break
        # done
        # [[ "$answer" =~ ^[Yy]$ ]] && break
        break
    else
        echo '请输入正确的域名'
    fi
done
domain="$new_domain"
echo


while true; do
    new_email=$(bash -c "read -p '邮箱(默认当前 $email): ' c; echo \$c")
    [ "$new_email" = '' ] && new_email="$email" && break
    if [[ "$new_email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
        # while true; do
        #     answer=$(bash -c "read  -n 1 -p '确认域名: $new_email ? [Y|N]' c; echo \$c"); echo
        #     [[ "$answer" =~ ^[YyNn]$ ]] && break
        # done
        # [[ "$answer" =~ ^[Yy]$ ]] && break
        break
    else
        echo '请输入正确的邮箱'
    fi
done
email="$new_email"
echo


echo "UUID:"
echo "[0] 当前UUID: $UUID"
echo "[1] 使用自动生成的UUID"
echo "[2] 自定义UUID"

while true; do
    UUID_scheme=$(bash -c "read -n 1 -p '选择UUID类型 (默认 0): ' c; echo \$c"); echo
    [ "$UUID_scheme" = '' ] && UUID_scheme=0
    if [ "$UUID_scheme" = '0' ]; then
        break
    elif [ "$UUID_scheme" = '1' ]; then
        UUID="$(cat /proc/sys/kernel/random/uuid)"
        echo "UUID: ${UUID}"
        break
    elif [ "$UUID_scheme" = '2' ]; then
        UUID=$(bash -c "read -p '自定义 UUID: ' c; echo \$c")
        if [[ "$UUID" =~ ^[0-9a-z]{8}(-[0-9a-z]{4}){3}-[0-9a-z]{12}$ ]]; then
            # while true; do
            #     answer=$(bash -c "read  -n 1 -p '确认UUID: $UUID ? [Y|N]' c; echo \$c"); echo
            #     [[ "$answer" =~ ^[YyNn]$ ]] && break
            # done
            # [[ "$answer" =~ ^[Yy]$ ]] && break
            break
        else
            echo '请输入正确的UUID'
        fi
    else
        echo '请输入正确的方案UUID类型'
    fi
done
echo


if [ "$scheme" = 'lnv' ]; then
    while true; do
        new_v2ray_path=$(bash -c "read -p 'v2ray路径(需是绝对路径, 以'/'开始, 默认当前 ${v2ray_path}): ' c; echo \$c")
        [ "$new_v2ray_path" = '' ] && new_v2ray_path="$v2ray_path" && break
        if [[ "$new_v2ray_path" =~ ^/.* ]]; then
            # while true; do
            #     answer=$(bash -c "read  -n 1 -p '确认域名: $new_v2ray_path ? [Y|N]' c; echo \$c"); echo
            #     [[ "$answer" =~ ^[YyNn]$ ]] && break
            # done
            # [[ "$answer" =~ ^[Yy]$ ]] && break
            break
        else
            echo "需是绝对路径, 以'/'开始"
        fi
    done
    v2ray_path="$new_v2ray_path"
    echo
fi
# while true; do


#     while true; do
#         answer=$(bash -c "read  -n 1 -p '使用自动生成的 UUID ? [Y|N]' c; echo \$c"); echo
#         [[ "$answer" =~ ^[YyNn]$ ]] && break
#     done

#     if [[ "$answer" =~ ^[Yy]$ ]]; then
#         UUID="$(cat /proc/sys/kernel/random/uuid)"
#         echo "UUID: ${UUID}"
#         break
#     else
#         UUID=$(bash -c "read -p '自定义 UUID: ' c; echo \$c")
#         if [[ "$UUID" =~ ^[0-9a-z]{8}(-[0-9a-z]{4}){3}-[0-9a-z]{12}$ ]]; then
#             while true; do
#                 answer=$(bash -c "read  -n 1 -p '确认UUID: $UUID ? [Y|N]' c; echo \$c"); echo
#                 [[ "$answer" =~ ^[YyNn]$ ]] && break
#             done
#             [[ "$answer" =~ ^[Yy]$ ]] && break
#         else
#             echo '请输入正确的UUID'
#         fi
#     fi
# done
# echo

# get absoltae path to the dir this is in, work in bash, zsh
# if you want transfer symbolic link to true path, just change `pwd` to `pwd -P`
here=$(cd "$(dirname "${BASH_SOURCE[0]-$0}")"; pwd)
repo_root="$here/.."


if [ "$scheme" = 'lnvh' ]; then
    templates=(
        "${repo_root}/certbot/docker-compose.yml.template"
        "${repo_root}/certbot/nginx/conf.d/web.conf.template"
        "${repo_root}/lnvh/docker-compose.yml.template"
        "${repo_root}/lnvh/v2ray/config.json.template"
        "${repo_root}/lnvh/nginx/conf.d/redirect.conf.template"
        "${repo_root}/lnvh/nginx/conf.d/web.conf.template"
        "${repo_root}/lnvh/haproxy/haproxy.cfg.template"
        "${repo_root}/lnvh/update-cert/update-cert.sh.template"
    )
elif [ "$scheme" = 'lnv' ]; then
    templates=(
        "${repo_root}/certbot/docker-compose.yml.template"
        "${repo_root}/certbot/nginx/conf.d/web.conf.template"
        "${repo_root}/lnv/docker-compose.yml.template"
        "${repo_root}/lnv/v2ray/config.json.template"
        "${repo_root}/lnv/nginx/conf.d/redirect.conf.template"
        "${repo_root}/lnv/nginx/conf.d/ssl.conf.template"
    )
else
    echo "不支持自动配置 $scheme 方案"
    exit 1
fi

echo "参数填入配置文件:"

for template in "${templates[@]}"; do
    configfile="${template/.template/}"
    sed -e "s/example.com/${domain}/g" \
        -e "s/youremail/${email}/g" \
        -e "s/UUID/${UUID}/g" \
        -e "s|/your_v2ray_path|${v2ray_path}|g" \
        "$template" > "$configfile"

    # echo "-----------------"
    echo "$configfile"
    # cat $configfile
done
echo

echo "scheme='$scheme'
email='$email'
domain='$domain'
UUID='$UUID'
v2ray_path='$v2ray_path'"  >  "$here/metaconfig.sh"