#
FROM centos_base
MAINTAINER xiaocai <miss339742811@163.com>

#add user
#RUN groupadd worker
#RUN useradd -g worker worker

#install nginx
ADD ./package/nginx-1.5.7.tar.gz /data/install/
ADD ./install_nginx.sh /data/install/install_nginx.sh

RUN chmod 755 /data/install/install_nginx.sh
RUN /data/install/install_nginx.sh

#install php
ADD ./package/php-5.4.40.tar.gz /data/install/
ADD ./package/libiconv-1.14.tar.gz /data/install/
ADD ./package/libmcrypt-2.5.8.tar.gz /data/install/
ADD ./install_php.sh /data/install/install_php.sh
RUN chmod 755 /data/install/install_php.sh
RUN /data/install/install_php.sh

#install php-extensions
ADD ./package/yaf-2.3.3.tgz /data/install/
ADD ./package/phpredis-develop.tar.gz /data/install/
ADD ./package/mongo-1.6.7.tgz /data/install/
ADD ./install_php-extensions.sh /data/install/install_php-extensions.sh
RUN chmod 755 /data/install/install_php-extensions.sh
RUN /data/install/install_php-extensions.sh

#start.sh
ADD ./start.sh /data/start.sh
RUN chmod 755 /data/start.sh

RUN rm -rf /data/install/*

ENTRYPOINT ["/data/start.sh"]
EXPOSE 80