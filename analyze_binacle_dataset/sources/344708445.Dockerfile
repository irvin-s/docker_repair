FROM debian:stable


RUN apt-get update && apt-get install --no-install-recommends -y apt-transport-https lsb-release ca-certificates net-tools lsof postgresql-client wget \
    && apt-get install --no-install-recommends -y git curl build-essential unzip python-pip python-setuptools \
    && apt-get install --no-install-recommends -y dnsutils vim-nox\
    && apt-get autoremove -y && apt-get clean

#default-jre-headless xvfb
#RUN echo "deb http://http.debian.net/debian unstable main" > /etc/apt/sources.list.d/firefox.list && apt-get update && apt-get install --no-install-recommends -y firefox\
#    && apt-get autoremove -y && apt-get clean

# for full only && default-jre-headless xvfb firefox-esr dnsutils vim

ARG PHPVER=5.6
RUN echo "deb http://ftp.debian.org/debian $(lsb_release -sc)-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y php${PHPVER} php${PHPVER}-cli php${PHPVER}-pgsql php${PHPVER}-mysql php${PHPVER}-curl php${PHPVER}-json php${PHPVER}-gd php${PHPVER}-mcrypt php${PHPVER}-intl php${PHPVER}-sqlite3 php${PHPVER}-gmp php${PHPVER}-geoip php${PHPVER}-mbstring php${PHPVER}-redis php${PHPVER}-xml php${PHPVER}-zip php${PHPVER}-xdebug \
    && apt-get install --no-install-recommends -y php${PHPVER}-xdebug \
    && apt-get autoremove -y && apt-get clean

RUN echo "phar.readonly = Off" >> /etc/php/${PHPVER}/cli/conf.d/42-phar-readonly.ini \
    && echo "memory_limit=-1" >> /etc/php/${PHPVER}/cli/conf.d/42-memory-limit.ini \
    && echo "date.timezone=Europe/Paris" >>  /etc/php/${PHPVER}/cli/conf.d/68-date-timezone.ini

RUN mkdir -p /data/Repository && chown www-data:www-data /data/Repository

ENV HOME=/home/jenkins
ENV USER=jenkins
ENV GROUP=users


ARG UID
ARG GID
RUN useradd -d $HOME -g ${GID} -u ${UID} -m $USER \
    && usermod -a -G www-data ${USER} \
    && mkdir -p $HOME/bin \
    && chown -R $USER:$GROUP $HOME

ARG ETCDVER=3.3.1
RUN wget -q https://github.com/coreos/etcd/releases/download/v${ETCDVER}/etcd-v${ETCDVER}-linux-amd64.tar.gz -O /tmp/etcd.tar.gz \
    && tar -xvzf /tmp/etcd.tar.gz -C /tmp \
    && mv /tmp/etcd-v${ETCDVER}-linux-amd64/etcd* /usr/local/bin/ \
    && chmod 755 /usr/local/bin/etcd* \
    && rm -rf /tmp/etcd*

ARG CONFDVER=0.15.0
RUN wget -q https://github.com/kelseyhightower/confd/releases/download/v${CONFDVER}/confd-${CONFDVER}-linux-amd64 -O /usr/local/bin/confd \
    && chmod 755 /usr/local/bin/confd \
    && mkdir -p /etc/confd/conf.d \
    && mkdir -p /etc/confd/templates

USER $USER:$GROUP
WORKDIR $HOME

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin/:$HOME/bin:$HOME/.local/bin/
