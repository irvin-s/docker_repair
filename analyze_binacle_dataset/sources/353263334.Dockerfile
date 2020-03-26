FROM k0st/alpine-apache-php
MAINTAINER kost - https://github.com/kost

ENV VERSION_ERAMBA 204015_div1

RUN apk --update add php-ctype php-mysql php-pdo_mysql mysql-client && rm -f /var/cache/apk/* && \
curl https://s3.eu-central-1.amazonaws.com/dlh/eramba/eramba_$VERSION_ERAMBA.tgz -o /tmp/eramba_$VERSION_ERAMBA.tgz && \
tar -xvz -C /app -f /tmp/eramba_$VERSION_ERAMBA.tgz && \
rm -f /tmp/eramba_$VERSION_ERAMBA.tgz && \
mv /app/eramba_v2/* /app/ && \
mv /app/eramba_v2/.htaccess /app/ && \
mkdir /app/app/tmp/cache/persistent && \
mkdir /app/app/tmp/cache/models && \
mkdir /config && \
chown -R apache:apache /app && \
mv /app/app/Config /config/Config && \
rm -rf /app/eramba_v2/ && \
echo "Success"

# VOLUME ["/app/app/tmp/logs","/app/app/webroot/files","/var/log"]
VOLUME ["/app/app/Config","/app/app/tmp/logs","/app/app/webroot/files","/var/log"]

ADD scripts/ /scripts

