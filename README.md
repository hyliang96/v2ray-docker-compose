# 使用方法

## 域名解析

域名解析A记录

## 安装方法

```bash
git clone https://github.com/hyliang96/v2ray-docker-compose.git
cd v2ray-docker-compose
. ./script.sh
```

运行一键脚本

```bash
v2docker
```

* 初次使用: 跟随脚本引导, 安装 docker, docker-compose, 开启swap, 配置并启动.

* 之后使用: 跟随脚本引导, 开启或关闭 v2docker, 查看log, 显示 v2ray 配置.

# 参考

## 安装docker和docker-compose

[安装docker](https://docs.docker.com/install/)

[安装docker-compose](https://docs.docker.com/compose/install/)

建议安装完成后切换到普通用户，将普通用户添加到docker用户组，不要用root用户使用dockers。

