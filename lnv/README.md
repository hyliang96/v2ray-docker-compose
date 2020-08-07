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
将"your_v2ray_path"替换成你自己的。

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
nano nginx/conf.d/ssl.conf
```
找到以下行
```bash
server_name example.com www.example.com;
ssl_certificate /etc/nginx/ca/live/example.com/fullchain.pem;
ssl_certificate_key /etc/nginx/ca/live/example.com/privkey.pem;
```
将example.com替换成你的域名。`server_name`可使用一个或多个域名, 写作 `server_name [域名 [域名 [ ...]]];`。

找到以下行

```bash
 location /your_v2ray_path {
```
将"your_v2ray_path"替换成你自己的。

# 将你自己的网站放到nginx/www目录下

如题

# 启动容器

```bash
docker-compose up
```
如果没成功请Ctrl+C.

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

证书会在每次`docker-compose up`的时候自动更新。
重启服务器容器会自动重启，但是证书不会更新。
建议制定计划任务，定时执行更新证书的脚本。
更新证书的脚本内容可能如下：

```bash
#!/bin/bash
cd /home/youruser/lnv
COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"

$COMPOSE run certbot renew && $COMPOSE kill -s SIGHUP nginx
$DOCKER system prune -af


```
