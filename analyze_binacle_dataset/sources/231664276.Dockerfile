FROM edbizarro/gitlab-ci-pipeline-php:7.1

LABEL maintainer "Eduardo Bizarro <eduardo@zendev.com.br>" \
      php="7.1" \
      node="9" \
      mysql="5.7"

ENV PATH=$HOME/.yarn/bin:$PATH
ENV COMPOSER_HOME=$HOME/composer
ENV GOSU_VERSION=1.7
ENV MYSQL_MAJOR=5.7
ENV MYSQL_VERSION=5.7.21-1debian8

USER root

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
		&& apt-get update && apt-get install -y --no-install-recommends wget && rm -rf /var/lib/apt/lists/* \
		&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
		&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
		&& export GNUPGHOME="$(mktemp -d)" \
		&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
		&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
		&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
		&& chmod +x /usr/local/bin/gosu \
		&& gosu nobody true \
		&& apt-get purge -y --auto-remove wget \
		&& apt-get update && apt-get install -y --no-install-recommends \
  		# pwgen \
  		openssl \
  		perl \
		&& rm -rf /var/lib/apt/lists/* \
		&& set -ex; \
		key='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
		export GNUPGHOME="$(mktemp -d)"; \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
		gpg --export "$key" > /etc/apt/trusted.gpg.d/mysql.gpg; \
		rm -r "$GNUPGHOME"; \
		apt-key list > /dev/null \
		&& echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list \
		&& { \
		echo mysql-community-server mysql-community-server/data-dir select ''; \
		echo mysql-community-server mysql-community-server/root-pass password ''; \
		echo mysql-community-server mysql-community-server/re-root-pass password ''; \
		echo mysql-community-server mysql-community-server/remove-test-db select false; \
	} | debconf-set-selections \
	&& apt-get update && apt-get install -y mysql-server="${MYSQL_VERSION}" && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld \
	# && sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/mysql.conf.d/mysqld.cnf \
	# 	&& echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/mysql/conf.d/docker.cnf \
	&& apt-get remove --purge -yqq $BUILD_PACKAGES \
	&& apt-get autoclean -y \
	&& apt-get --purge autoremove -y && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER php

VOLUME /var/lib/mysql
