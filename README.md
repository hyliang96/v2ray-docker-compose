# 使用方法

## 域名解析

域名解析A记录


## 安装docker和docker-compose

[安装docker](https://docs.docker.com/install/)

[安装docker-compose](https://docs.docker.com/compose/install/)

建议安装完成后切换到普通用户，将普通用户添加到docker用户组，不要用root用户使用dockers。

## 下载v2ray-docker-compose到服务器

```bash
git clone https://github.com/hyliang96/v2ray-docker-compose.git
```

## 申请证书

进入`v2ray-docker-compose/certbot/`目录，修改docker-compose.yml中的command,

```bash
nano docker-compose.yml
```
找到如下行：
```bash
command: certonly --webroot --webroot-path=/var/www/html --email youremail --agree-tos --no-eff-email --staging -d example.com -d www.example.com
```
将`youremail`替换成你的邮箱，将`example.com`替换成你的域名。可使用一个或多个域名, 每个域名写一条 `-d 域名` 。

### 修改conf.d中的web.conf
```bash
nano nginx/conf.d/web.conf
```

找到如下行：
```bash
server_name www.example.com example.com;
```
将example.com换成你的域名。可使用一个或多个域名, 写作 `server_name [域名 [域名 [ ...]]];`。

### 启动容器申请证书
```bash
docker-compose up
```
申请完成后Ctrl+C停止容器,然后执行以下命令销毁容器。
```bash
docker-compose down
```


## 复制certbot-etc目录

如果你想用v2ray websocket nginx tls，请将`certbot-etc`目录复制到`v2ray-docker-compose/lnv`,
如果你想用v2ray nginx haproxy tls, 请将`certbot-etc`目录复制到`v2ray-docker-compose/lnvh`。

文件复制完成后请进入相应的文件夹（`lnv/`或`lnvh/`）查看README.md。

