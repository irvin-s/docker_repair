FROM ubuntu:16.04
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ADD includes/ /includes/

RUN useradd -m -d /home/taiga -s /bin/bash taiga && \
    apt-get -q update && \
    apt-get -q dist-upgrade -y && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y build-essential binutils-doc autoconf flex bison libjpeg-dev && \
    apt-get install -y libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev && \
    apt-get install -y automake libtool libffi-dev curl git tmux gettext && \
    apt-get install -y nginx && \
    apt-get install -y rabbitmq-server redis-server && \
    apt-get install -y circus && \
    apt-get install -y python3 python3-pip python-dev python3-dev python-pip virtualenvwrapper && \
    apt-get install -y libxml2-dev libxslt-dev && \
    apt-get install -y libssl-dev libffi-dev && \
    apt-get install -y supervisor && \
    apt-get install -y postgresql-contrib postgresql-server-dev-all && \
    npm install -g coffee-script gulp bower && \
    mkdir -p /home/taiga/conf/ /home/taiga/logs && \
    mv -f /includes/etc/circus/conf.d /etc/circus && \
    mv -f /includes/etc/supervisor/conf.d /etc/supervisor && \
    rm -f /etc/nginx/sites-enabled/default && \
    mv -f /includes/etc/nginx/nginx.conf /etc/nginx && \
    mv -f /includes/etc/nginx/sites-enabled/taiga-http /etc/nginx/sites-enabled/taiga && \
    apt-get -qq autoremove --purge -y && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /home/taiga/*/.git && \
    chown -R taiga:taiga /home/taiga

USER taiga
RUN git clone https://github.com/taigaio/taiga-back.git /home/taiga/taiga-back && \
    cd /home/taiga/taiga-back && \
    git checkout stable  && \
    bash -c "source /usr/share/virtualenvwrapper/virtualenvwrapper.sh && mkvirtualenv -p /usr/bin/python3.5 taiga && pip install --upgrade pip setuptools && pip install -r requirements.txt" && \
    git clone https://github.com/taigaio/taiga-front.git /home/taiga/taiga-front-dist && \
    cd /home/taiga/taiga-front-dist && \
    git checkout stable && \
    git clone https://github.com/taigaio/taiga-events.git /home/taiga/taiga-events && \
    cd /home/taiga/taiga-events && \
    npm install

USER root

COPY entrypoint.sh /entrypoint.sh

EXPOSE 80/tcp 443/tcp 8888/tcp

ENTRYPOINT ["/entrypoint.sh"]
