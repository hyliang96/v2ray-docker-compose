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
将"your_v2ray_path"替换成你自己的。

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
nano nginx/conf.d/ssl.conf
```
找到以下行
```bash
server_name example.com www.example.com;
ssl_certificate /etc/nginx/ca/live/example.com/fullchain.pem;
ssl_certificate_key /etc/nginx/ca/live/example.com/privkey.pem;
```
将example.com替换成你的域名。
找到以下行

```bash
 location /your_v2ray_path {
```
将"your_v2ray_path"替换成你自己的。

# 将你自己的网站放到nginx/www目录下。

# 启动容器

```bash
docker-compose up
```
如果没成功请Ctrl+C，如果运行成功直接关闭终端。

# 最后的说明

证书会在每次"docker-compose up"的时候自动更新。
重启服务器容器会自动重启，但是证书不会更新。
建议制定计划任务，定时执行更新证书的脚本。
更新证书的脚本内容可能如下：

```bash
#!/bin/bash
cd $HOME/lnvh
/usr/local/bin/docker-compose down
while /usr/bin/curl example.com; do sleep 1; done
sleep 15
/usr/local/bin/docker-compose up -d
```
