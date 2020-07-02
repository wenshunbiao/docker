# coreos docker

## install docker
    
see https://www.cnblogs.com/yufeng218/p/8370670.html

## init

    useradd core
    cd /home/core
    git clone https://github.com/wenshunbiao/docker.git
    chmod -R 777 docker/shell
    /home/core/docker/shell/shell_init
    export PATH="/home/core/docker/shell:$PATH"
    install

## ssh-init

    ssh_config www.youname.com 

## set timezone

    sudo timedatectl set-timezone Asia/Shanghai

## set hostname

    sudo hostnamectl set-hostname yourname

## start/restart web service

    web

## install other service

    s bind                          # install bind server
    s samba                         # install samba share
    s git                           # install git server

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
