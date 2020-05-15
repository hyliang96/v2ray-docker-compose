# 修改docker-compose.yml

```bash
nano docker-compose.yml
```
找到以下行
```bash
ommand: certonly --webroot --webroot-path=/var/www/html --email youremail --agree-tos --no-eff-email --force-renewal -d example.com -d www.example.com
```
将youremail替换为你的邮箱，将example.com替换成你的域名。

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
将example.com替换成你的域名。

```bash
nano nginx/conf.d/web.conf
```
找到以下行
```bash
server_name example.com www.example.com;
```
将example.com替换成你的域名。
找到以下行

# 将你自己的网站放到nginx/www目录下。

# 修改haproxy配置文件

```bash
nano haprxy.cfg
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

## 也可以这样：

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

如果成功了就直接关闭终端。


# 最后的说明

证书会在每次"docker-compose up"的时候自动更新。
重启服务器容器会自动重启，但是证书不会更新。
建议制定计划任务，定时执行更新证书的脚本。
更新证书的脚本内容可能如下：

```bash
#!/bin/bash
cd /home/youruser/lnvh/
CERT_HOME=certbot-etc/live/example.com
COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"


$COMPOSE run certbot renew

cat $CERT_HOME/fullchain.pem > $CERT_HOME/example.com.pem
cat $CERT_HOME/privkey.pem >> $CERT_HOME/example.com.pem
#cat $CERT_HOME/fullchain.pem $CERT_HOME/privkey.pem | tee $CERT_HOME/example.com.pem

$COMPOSE kill -s SIGHUP haproxy

$DOCKER system prune -af

```
