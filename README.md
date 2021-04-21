# CoreOS Docker

让你更便捷、系统化的使用Docker管理你的服务，一键定制你的环境   
需借助 Systemd 服务管理，支持此服务的 Linux 系统都可安装，建议使用 Centos7 系统  

## Step.1 Install Docker
    
请自行安装Docker  
参考教程：https://www.cnblogs.com/yufeng218/p/8370670.html

## Step.2 Install CoreOS Docker

请使用root用户安装，忽略一些常规性的报错输出

    useradd -d /home/core -m core && cd /home/core
    git clone https://github.com/wenshunbiao/docker.git
    chmod -R 777 docker/shell && export PATH="/home/core/docker/shell:$PATH"
    install_coreos

安装到此结束，以下是一些使用示例或提示。
-----

## 一些常用服务及快捷命令列表

在 /home/core/docker 预先封装了大量服务，文件夹名称即是服务名称  
所有服务都安装在 /home/core/data 目录，需要修改服务的配置请在这里修改，改完使用 `s service_name` 重启生效

- 常用服务
  - `mysql`
  - `nginx`
  - `redis`
  - `php`
  - `daemon` supervisor守护进程服务
  - `ofelia` 秒级定时器，可替代crontab，能和docker容器更方便的交互，https://github.com/mcuadros/ofelia
  - `shadowsocks` 飞机场
  - ...

更多快捷命令请查看 /home/core/docker/shell 

- 快捷命令
  - `dps`              # show all docker services
  - `dpp`              # show all docker service mapping ports
  - `i service_name`   # install service
  - `s service_name`   # start/restart service service
  - `p service_name`   # stop service service
  - `d service_name`   # enter service container, if the error is reported, try `d service_name sh`
  - `j service_name`   # view service history log
  - `jf service_name`  # scroll to view service log
  - `st service_name`  # status systemctl service
  - `atop`             # 查看系统负载
  - `iotop`            # 查看系统I/O
  - `fio`              # 测试系统I/O
  - `docker_mirror_aliyun`  # 为docker配置阿里云源
  - ...

## install service

    i php                         # install php server
    i nginx                       # install nginx share
    i redis                       # install redis server

## start/restart service

    s php                         # start/restart php server
    s nginx                       # start/restart nginx share
    s redis                       # start/restart redis server

## command list

更多快捷命令请查看 /home/core/docker/shell

    dps                           # show all docker services
    dpp                           # show all docker service mapping ports
    i service_name                # install service
    s service_name                # start/restart service service
    p service_name                # stop service service
    d service_name                # enter service container, if the error is reported, try `d service_name sh`
    j service_name                # view service history log
    jf service_name               # scroll to view service log
    st service_name               # status systemctl service

## 致谢

感谢 [JetBrains](https://www.jetbrains.com/?from=coreos%20docker) 对开源项目的支持与帮助  

![avatar](./docs/images/jetbrains-variant-100.png)

## License

The CoreOS Docker is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
