# 修改docker-compose.yml

```bash
nano docker-compose.yml
```
找到以下行
```bash
ommand: certonly --webroot --webroot-path=/var/www/html --email youremail --agree-tos --no-eff-email --force-renewal -d example.com -d www.example.com
```
将youremail替换为你的邮箱，将example.com替换成你的域名。可使用一个或多个域名, 每个域名写一条 `-d 域名` 。

# 修改v2ray/config.json

```bash
nano v2ray/config.json
```
将UUID替换成你自己的UUID

# 修改nginx配置文件

```bash
nano nginx/conf.d/redirect.conf
```
找到以下行
```bash
server_name example.com www.example.com;
```
将example.com替换成你的域名。可使用一个或多个域名, 写作 `server_name [域名 [域名 [ ...]]];`。

```bash
nano nginx/conf.d/web.conf
```
找到以下行
```bash
server_name example.com www.example.com;
```
将example.com替换成你的域名。可使用一个或多个域名, 写作 `server_name [域名 [域名 [ ...]]];`。

# 将你自己的网站放到`nginx/www/`目录下

如题

# 修改haproxy配置文件

```bash
nano haproxy/haproxy.cfg
```
找到以下行：
```bash
bind *:443 tfo ssl crt /etc/ca/live/example.com/example.com.pem
```
将example.com替换成你自己的域名。

# 生成证书

Letencrypt证书haproxy无法直接使用，需要将证书合并：
```bash
cat certbot-etc/live/example.com/fullchain.pem > certbot-etc/live/example.com/example.com.pem
cat certbot-etc/live/example.com/privkey.pem >> certbot-etc/live/example.com/example.com.pem
```

也可以这样：

```bash
cd certbot-etc/live/example.com
cat fullchain.pem privkey.pem | tee example.com.pem
```

其中example.com需要替换成你自己的域名。

# 启动容器

```bash
cd $HOME/lnvh
docker-compose up
```
如果没成功请Ctrl+C然后修改。

如果成功了就直接关闭终端, docker即在后台运行.

也可`docker-compose up -d` 直接开启docker在后台运行.

# 查看log

## 查看容器log

查看有所有的docker

```bash
docker ps -a
```

```
CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS                     PORTS                  NAMES
a357ad394ec4        haproxy:latest            "/docker-entrypoint.…"   10 hours ago        Up 10 hours                0.0.0.0:443->443/tcp   haproxy
b2a995b9238f        certbot/certbot           "certbot certonly --…"   10 hours ago        Exited (1) 10 hours ago                           certbot
3c6c50de872e        nginx:alpine              "/docker-entrypoint.…"   10 hours ago        Up 10 hours                0.0.0.0:80->80/tcp     nginx
442bab1f262b        v2fly/v2fly-core:latest   "v2ray -config=/etc/…"   10 hours ago        Up 10 hours                                       v2ray
```

显示目标docker的log

```bash
docker logs <CONTAINER-ID>
```

## 查看v2ray的log

```bash
tail -n 20 v2ray-docker-compose/lnvh/v2ray/log/*.log
```

其中`-n <行数> `

# 最后的说明

在每次`docker-compose up`的时候, 证书会尝试自动更新, 但不会自动合并证书.

镜像运行证书3个月过期, 故需要定时更新证书

`crontab -e`, 结尾输入

```bash
0 4 5,15,25 * * bash <path-to-this-repo>/lnvh/update-cert/update-cert.sh
# 按照crontab的规则, 结尾必需空一行
```

则每个月的5/15/25日凌晨4:00会自动尝试更新证书. 若证书即将过期, 则完成更新 而后并合并证书.