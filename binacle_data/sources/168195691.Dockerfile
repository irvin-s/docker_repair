FROM ubuntu:latest
RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget mysql-client mysql-server \
		apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql  php5-ldap php5-curl 
RUN easy_install supervisor
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
ADD ./configs/supervisord.conf /etc/supervisord.conf
ADD ./configs/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN mkdir /var/log/supervisor/
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.0.1/dockerize-linux-amd64-v0.0.1.tar.gz
RUN tar -C /usr/local/bin -xvzf dockerize-linux-amd64-v0.0.1.tar.gz

ADD ./scripts/start.sh /start.sh
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh

RUN rm -rf /var/www/
ADD http://wordpress.org/latest.tar.gz /wordpress.tar.gz
RUN tar xvzf /wordpress.tar.gz 
RUN mv /wordpress /var/www/
RUN chown -R www-data:www-data /var/www/

EXPOSE 80 3306

# exclude logs from image
VOLUME /var/log
# use dockerize for redirecting logs to stdout/stderr
#CMD dockerize \
#	-stderr /var/log/mysql/error.log \
#	-stderr /var/log/mysql.err \
#	-stdout /var/log/mysql.log \
#	-stdout /var/log/faillog \
#	-stdout /var/log/bootstrap.log \
#	-stdout /var/log/alternatives.log \
#	/start.sh

CMD /start.sh
