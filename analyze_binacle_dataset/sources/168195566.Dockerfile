FROM centos:centos7

MAINTAINER xuwang@gmail.com

RUN yum -y install epel-release \
    && yum -y update \
    && yum -y install httpd mod_ssl php php-mcrypt php-pear php-xml php-pdo wget php-mysql \
    && yum -y clean all

RUN ssp_version=1.14.1; \
    ssp_hash=91d43063ca8ca38260cc7c8ff3bdb0e439c59834303ccee726dd937e9c2f98ed; \   
    wget https://simplesamlphp.org/res/downloads/simplesamlphp-$ssp_version.tar.gz \
    && echo "$ssp_hash  simplesamlphp-$ssp_version.tar.gz" | sha256sum -c - \
	&& cd /var \
	&& tar xzf /simplesamlphp-$ssp_version.tar.gz \
    && mv simplesamlphp-$ssp_version simplesamlphp \
    && rm /simplesamlphp-$ssp_version.tar.gz

ADD load-confd.php /tmp/load-confd.php
RUN cat /tmp/load-confd.php >> /var/simplesamlphp/config/config.php && rm /tmp/load-confd.php

COPY httpd-foreground /usr/local/bin/

EXPOSE 80 443

CMD ["httpd-foreground"]
