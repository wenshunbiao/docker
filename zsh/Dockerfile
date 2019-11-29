FROM library/composer:1.6.3

RUN apk add --no-cache util-linux bash zsh git \
 && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
 && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

WORKDIR /www

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql
ENTRYPOINT ["/bin/zsh"]
