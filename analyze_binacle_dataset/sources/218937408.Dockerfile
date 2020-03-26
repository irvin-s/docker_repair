FROM ubuntu

ADD config /zurmo/zurmo/app/protected/config
ADD conf.d /etc/confd/apache/conf.d
ADD templates /etc/confd/apache/templates

RUN chown -R www-data /zurmo

VOLUME /zurmo/zurmo/app/protected/config
VOLUME /etc/confd/apache
