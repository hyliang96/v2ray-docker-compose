
while true; do
    domain=$(bash -c "read -p '域名(如 tcptls.example.com ): ' c; echo \$c")
    if [[ "$domain" =~ ^[a-zA-Z0-9][\-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][\-a-zA-Z0-9]{0,62})+$ && "$domain" =~ ^.{3,255}$ ]]; then
        while true; do
            answer=$(bash -c "read  -n 1 -p '确认域名: $domain ? [Y|N]' c; echo \$c"); echo
            [[ "$answer" =~ ^[YyNn]$ ]] && break
        done
        [[ "$answer" =~ ^[Yy]$ ]] && break
    else
        echo '请输入正确的域名'
    fi
done
echo


while true; do
    email=$(bash -c "read -p '邮箱(如 someone233@example.com): ' c; echo \$c")
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
        while true; do
            answer=$(bash -c "read  -n 1 -p '确认域名: $email ? [Y|N]' c; echo \$c"); echo
            [[ "$answer" =~ ^[YyNn]$ ]] && break
        done
        [[ "$answer" =~ ^[Yy]$ ]] && break
    else
        echo '请输入正确的邮箱'
    fi
done
echo


while true; do
    while true; do
        answer=$(bash -c "read  -n 1 -p '使用自动生成的 UUID ? [Y|N]' c; echo \$c"); echo
        [[ "$answer" =~ ^[YyNn]$ ]] && break
    done

    if [[ "$answer" =~ ^[Yy]$ ]]; then
        UUID="$(cat /proc/sys/kernel/random/uuid)"
        echo "UUID: ${UUID}"
        break
    else
        UUID=$(bash -c "read -p '自定义 UUID: ' c; echo \$c")
        if [[ "$UUID" =~ ^[0-9a-z]{8}(-[0-9a-z]{4}){3}-[0-9a-z]{12}$ ]]; then
            while true; do
                answer=$(bash -c "read  -n 1 -p '输入UUID: $UUID ? [Y|N]' c; echo \$c"); echo
                [[ "$answer" =~ ^[YyNn]$ ]] && break
            done
            [[ "$answer" =~ ^[Yy]$ ]] && break
        else
            echo '请输入正确的UUID'
        fi
    fi
done
echo



templates=(
    'certbot/template.docker-compose.yml'
    'certbot/nginx/conf.d/template.web.conf'
    'lnvh/template.docker-compose.yml'
    'lnvh/v2ray/template.config.json'
    'lnvh/nginx/conf.d/template.redirect.conf'
    'lnvh/nginx/conf.d/template.web.conf'
    'lnvh/haproxy/template.haproxy.cfg'
    'lnvh/update-cert/template.update-cert.sh'
)


for template in "${templates[@]}"; do
    echo "-----------------"
    configfile="${template/template./}"
    sed -e "s/example.com/${domain}/g" \
        -e "s/youremail/${email}/g" \
        -e "s/UUID/${UUID}/g" \
        "$template" > "$configfile"
    echo "$configfile"
    cat $configfile
done
