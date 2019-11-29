# PHPSTORM

* Preferences -> search "xdebug debug port" -> change "Debug port:9003"
* search "IDE KEY HOST PORT" -> change IDE key: "IDE key: PHPSTORM; Host: 172.17.8.101 ; Port: 9003;"
* Button Click: Start Listerning for PHP Debug Connections

# COREOS

* sudo vi ~/data/php/php.ini
* change xdebug open
* web

# CHROME

* url: chrome://extensions
* drag ~/docker/php/xdebug/xdebug.crx to install
* xdebug helper change IDE key to PhpStorm
* xdebug icon change to debug/profile/trace

# PHPSTORM

* open your php script set a breakpoint
* Remote file path is not mapped to any file path
* Click to setup up path mappings
* select the /Data/Web/data/www/project to /www/project

# PROBLEM

* all is done, and port is listen, make sure xdebug.remote_host is your ip.
