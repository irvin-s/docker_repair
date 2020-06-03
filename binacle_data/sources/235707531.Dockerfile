FROM nxswesolowski/ubuntu-php:7.2
MAINTAINER Rafal Wesolowski <wesolyy@gmail.com>

ADD .docker /opt/shopware
RUN /opt/shopware/install-shopware.sh


EXPOSE 22 80 3306 9000
CMD ["supervisord", "-n"]
