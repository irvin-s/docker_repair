FROM ubuntu:14.04
MAINTAINER tony.bussieres@ticksmith.com
RUN apt-get update --fix-missing
RUN apt-get upgrade -y

RUN apt-get install mysql-server  apache2 apache2-utils libapache2-mod-php5 libphp-adodb  libphp-phpmailer  ucf  php5-mysql -y
RUN apt-get install wget curl -y
RUN wget -q http://jaist.dl.sourceforge.net/project/mantisbt/mantis-stable/1.2.17/mantisbt-1.2.17.tar.gz
RUN apt-get install runit -y
RUN mkdir /opt/mantisbt
RUN tar xzf /mantisbt-1.2.17.tar.gz --no-same-owner --strip-components 1 -C /opt/mantisbt 
RUN rm ../mantisbt-1.2.17.tar.gz
RUN ln -s  /etc/sv/apache2 /etc/service/
RUN ln -s  /etc/sv/mysql /etc/service/
RUN mkdir -p /var/run/apache2/lock
RUN mkdir -p /var/log/apache2/
ADD etc/sv/apache2/ /etc/sv/apache2
ADD etc/sv/mysql/ /etc/sv/mysql
ADD etc/apache2/sites-available/001-mantisbt.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite 001-mantisbt

CMD ["/usr/sbin/runsvdir-start"]
