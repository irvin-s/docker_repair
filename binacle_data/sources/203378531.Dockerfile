FROM centos:6
#FROM fedora:latest
RUN yum install -y tar bzip2 httpd
MAINTAINER bruno@project-builder.org
# Get it before with wget https://download.owncloud.org/community/owncloud-7.0.15.tar.bz2
COPY owncloud-7.0.15.tar.bz2 /var/www/html/
RUN cd /var/www/html/ && tar xvfj owncloud-7.0.15.tar.bz2 && rm -f owncloud-7.0.15.tar.bz2
RUN yum install -y php php-dom php-mbstring php-pdo php-gd php-mysql
VOLUME /data/owncloud
#COPY config.php /var/www/html/owncloud/config
RUN chown -R apache:apache /var/www/html/owncloud /data/owncloud
CMD /usr/sbin/apachectl -DFOREGROUND -k start
EXPOSE 80
