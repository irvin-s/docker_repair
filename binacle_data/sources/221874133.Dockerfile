FROM xataz/nginx-php
MAINTAINER Barra <bxt@mondedie.fr>

ENV H5AI_VERSION 0.29.0

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U add \
    unzip \
    patch \
  && mkdir -p /var/www \
  && wget "http://release.larsjung.de/h5ai/h5ai-$H5AI_VERSION.zip" \
  && mkdir -p /usr/share/h5ai \
  && unzip "h5ai-$H5AI_VERSION.zip" -d /usr/share/h5ai && chown -R 991:991 /usr/share/h5ai

COPY class-setup.php.patch class-setup.php.patch
RUN patch -p1 -u -d /usr/share/h5ai/_h5ai/private/php/core/ -i /class-setup.php.patch && rm class-setup.php.patch

COPY h5ai.conf /nginx/sites-enabled/h5ai.conf

EXPOSE 8080
VOLUME [ "/var/www"  ]
