# coreOS docker

建议使用 Centos7 系统，因为要借助 Systemd 服务管理。

## install docker
    
see https://www.cnblogs.com/yufeng218/p/8370670.html

## init

    yum install -y git
    useradd core
    cd /home/core
    git clone https://github.com/wenshunbiao/docker.git
    chmod -R 777 docker/shell
    /home/core/docker/shell/shell_init
    export PATH="/home/core/docker/shell:$PATH"
    install

安装到此结束，以下是一些使用示例或提示。
-----

## set timezone

    sudo timedatectl set-timezone Asia/Shanghai

## install service

    i php                           # install php server
    i nginx                         # install nginx share
    i redis                         # install redis server

## start/restart service

    s php                           # start/restart php server
    s nginx                         # start/restart nginx share
    s redis                         # start/restart redis server

## config the server

    cd /home/core/data/nginx
    vi nginx.conf # config nginx domain

    cd /home/core/data/php
    vi php.ini # config php.ini

    cd /home/core/data/mysql
    vi my.cnf # config my.cnf

## command list

    dps                             #show all docker services
    i service_name                  #install service
    s service_name                  #start/restart service service
    p service_name                  #stop service service
    d service_name                  #enter service container, if the error is reported, try `d service_name sh`
    j service_name                  #view service history log
    jf service_name                 #scroll to view service log
    st service_name                 #status systemctl service
    web                             #start/restart service web service

## 致谢

感谢 [JetBrains](https://www.jetbrains.com/?from=coreos%20docker) 对开源项目的支持与帮助  

![avatar](./docs/images/jetbrains-variant-100.png)

## License

The CoreOS docker is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
