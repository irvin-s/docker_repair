FROM registry.cn-hangzhou.aliyuncs.com/thinkimf/iot:thinkimf
#22 连接ssh root thinkimf
#80 nginx
#3306 mysql
#8011 8012  swoole预留
MAINTAINER liuyabo 554251986@qq.com
EXPOSE  22 80 3306 8011 8012
#RUN /usr/local/nginx/sbin/nginx && service mysql restart && service ssh restart && /usr/local/php/sbin/php-fpm
#CMD /bin/bash
#CMD ["echo","welcome thinkimf"]
#CMD ["source","/etc/profile"]
#ENTRYPOINT ["/bin/bash","/usr/bin/open_service"]
#CMD ["/bin/bash"]  