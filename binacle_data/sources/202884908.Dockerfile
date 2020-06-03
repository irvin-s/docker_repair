FROM ubuntu:18.04
MAINTAINER showwin <showwin_kmc@yahoo.co.jp>

ENV LANG en_US.UTF-8

RUN apt-get update
RUN apt-get install -y wget sudo less vim tzdata

# ishocon ユーザ作成
RUN groupadd -g 1001 ishocon && \
    useradd  -g ishocon -G sudo -m -s /bin/bash ishocon && \
    echo 'ishocon:ishocon' | chpasswd
RUN echo 'ishocon ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# MySQL のインストール
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password ishocon'"]
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-service mysql-server/mysql-apt-config string 4'"]
RUN apt-get install -y mysql-server

# Nginx のインストール
RUN apt-get install -y nginx
COPY admin/ssl/ /etc/nginx/ssl/
COPY admin/config/nginx.conf /etc/nginx/nginx.conf

USER ishocon

# Ruby のインストール
RUN sudo apt-get install -y git ruby-dev libssl-dev libreadline-dev gcc make libmysqlclient-dev && \
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN PATH="$HOME/.rbenv/bin:$PATH" && \
    eval "$(rbenv init -)" && \
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    rbenv install 2.5.1 && rbenv rehash && rbenv global 2.5.1

# Python のインストール
RUN sudo apt-get install -y curl
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    PYENV_ROOT="$HOME/.pyenv" && PATH="$PYENV_ROOT/bin:$PATH" && \
    eval "$(pyenv init -)" && \
    pyenv install 3.6.5 && pyenv global 3.6.5 && \
    cd && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && rm get-pip.py

# Go のインストール
RUN sudo wget https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz && \
    sudo tar -C /usr/local -xzf go1.10.2.linux-amd64.tar.gz && \
    sudo rm go1.10.2.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
ENV GOROOT /usr/local/go
ENV GOPATH $HOME/.local/go
ENV PATH $PATH:$GOROOT/bin

# PHP のインストール
RUN sudo mkdir /run/php
RUN sudo apt install -y php php-fpm php-mysql php-cli

# NodeJS のインストール
RUN sudo apt install -y nodejs npm

# Crystal のインストール
RUN curl https://dist.crystal-lang.org/apt/setup.sh | sudo bash
RUN sudo apt install -y libssl1.0-dev crystal

# アプリケーション
RUN mkdir /home/ishocon/data /home/ishocon/webapp
COPY admin/ishocon2.dump.tar.bz2 /home/ishocon/data/ishocon2.dump.tar.bz2
COPY webapp/ /home/ishocon/webapp
COPY admin/config/bashrc /home/ishocon/.bashrc

# ライブラリのインストール
RUN cd /home/ishocon/webapp/ruby && sudo gem install bundler && bundle install
RUN LC_ALL=C.UTF-8 && LANG=C.UTF-8 && cd /home/ishocon/webapp/python && \
    /home/ishocon/.pyenv/shims/pip install -r requirements.txt
RUN cd /home/ishocon/webapp/php && \
    sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    sudo php composer-setup.php && \
    sudo php -r "unlink('composer-setup.php');" && \
    sudo php ./composer.phar install
RUN cd /home/ishocon/webapp/nodejs && \
    sudo npm install
RUN cd /home/ishocon/webapp/crystal && \
    shards install

COPY docker/start_app.sh /docker/start_app.sh

WORKDIR /home/ishocon
EXPOSE 443
