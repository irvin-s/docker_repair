FROM openjdk:8-alpine

# Setup useful environment variables
ENV BAMBOO_HOME     /var/atlassian/application-data/bamboo
ENV BAMBOO_INSTALL  /opt/atlassian/bamboo
ENV BAMBOO_VERSION  6.3.3

# Install Atlassian Bamboo and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apk add --no-cache curl xmlstarlet git openssh bash \
    && mkdir -p               "${BAMBOO_HOME}/lib" \
    && chmod -R 700           "${BAMBOO_HOME}" \
    && chown -R daemon:daemon "${BAMBOO_HOME}" \
    && mkdir -p               "${BAMBOO_INSTALL}" \
    && curl -Ls               "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz" | tar -zx --directory  "${BAMBOO_INSTALL}" --strip-components=1 --no-same-owner \
    && curl -Ls                "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz" | tar -xz --directory "${BAMBOO_INSTALL}/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar" \
    && chmod -R 700           "${BAMBOO_INSTALL}" \
    && chown -R daemon:daemon "${BAMBOO_INSTALL}" \
    && sed --in-place         's/^# umask 0027$/umask 0027/g' "${BAMBOO_INSTALL}/bin/setenv.sh" \
    && xmlstarlet             ed --inplace \
        --delete              "Server/Service/Engine/Host/@xmlValidation" \
        --delete              "Server/Service/Engine/Host/@xmlNamespaceAware" \
                              "${BAMBOO_INSTALL}/conf/server.xml" \
    && touch -d "@0"          "${BAMBOO_INSTALL}/conf/server.xml"

ENV PHP_INI_DIR 				/usr/local/etc/php
ENV TIMEZONE            Europe/Madrid
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          500M
ENV PHP_MAX_FILE_UPLOAD 200M
ENV PHP_MAX_POST        200M

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
		apk update && \
		apk upgrade && \
		apk add --update tzdata && \
		cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
		echo "${TIMEZONE}" > /etc/timezone && \
		apk add --update \
			git \
			php7-mcrypt \
			php7-soap \
			php7-openssl \
			php7-gmp \
			php7-pdo_odbc \
			php7-json \
			php7-intl \
			php7-pcntl \
			php7-dom \
			php7-pdo \
			php7-zip \
			php7-mysqli \
			php7-mongodb \
			php7-sqlite3 \
			php7-pdo_pgsql \
			php7-bcmath \
			php7-gd \
			php7-dev \
			php7-redis \
			php7-odbc \
			php7-pdo_mysql \
			php7-pdo_sqlite \
			php7-sockets \
			php7-pgsql \
			php7-ssh2 \
			php7-gettext \
      php7-xml \
			php7-xml \
			php7-xmlwriter \
			php7-xmlrpc \
			php7-simplexml \
      php7-xdebug \
			php7-bz2 \
			php7-iconv \
			php7-pdo_dblib \
			php7-curl \
			php7-ctype \
      php7-phar \
			php7-tokenizer \
      php7-mbstring

RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
		sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
		sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
		sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
		sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
		sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN	apk add nodejs

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    libffi \
    build-base \
		ansible \
		aws-cli

RUN	apk add docker \
	 	&& pip install -U docker-compose

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
# USER daemon:daemon

# Expose default HTTP and SSH ports.
EXPOSE 8085 54663

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/bamboo","/opt/atlassian/bamboo/logs"]

# Set the default working directory as the Bamboo home directory.
WORKDIR /var/atlassian/bamboo

COPY "docker-entrypoint.sh" "/"
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian Bamboo as a foreground process by default.
CMD ["/opt/atlassian/bamboo/bin/start-bamboo.sh", "-fg"]
