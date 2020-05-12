# 使用方法

## 域名解析

域名解析A记录


## 安装docker和docker-compose

[安装docker](https://docs.docker.com/install/)

[安装docker-compose](https://docs.docker.com/compose/install/)

建议安装完成后切换到普通用户，将普通用户添加到docker用户组，不要用root用户使用dockers。

## 下载v2ray-docker-compose到服务器

```bash
git clone https://github.com/Bond171/v2ray-docker-compose.git
```

## 申请证书

### 进入v2ray-docker-compose/certbot目录，修改docker-compose.yml中的command,
```bash
nano docker-compose.yml
```
找到如下行：
```bash
command: certonly --webroot --webroot-path=/var/www/html --email youremail --agree-tos --no-eff-email --staging -d example.com -d www.example.com
```
将youremail替换成你的邮箱，将example.com替换成你的域名。

### 修改conf.d中的web.conf
```bash
nano nginx/config.d/web.conf
```

找到如下行：
```bash
server_name www.example.com example.com;
```
将example.com换成你的域名。

### 启动容器申请证书
```bash
docker-compose up
```
申请完成后Ctrl+C停止容器,然后执行以下命令销毁容器。
```bash
docker-compose down
```


## 复制certbot-etc目录

如果你想用v2ray websocket nginx tls，请将certbot-etc目录复制到v2ray-docker-compose/lnv,
如果你想用v2ray nginx haproxy tls, 请将certbot-etc目录复制到v2ray-docker-compose/lnvh。

文件复制完成后请进入相应的文件夹（lnv或lnvh）查看README.md。

