FROM ubuntu:precise
MAINTAINER Martin Gondermann magicmonty@pagansoft.de

# Install all that’s needed
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install mysql-client apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql openssh-server sudo php5-ldap unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN easy_install supervisor

# Add all config and start files
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisord /var/run/sshd
RUN chmod 755 /start.sh && chmod 755 /etc/apache2/foreground.sh

# Set Apache user and log
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

VOLUME ["/data"]

# Add site to apache
ADD ./joomla /etc/apache2/sites-available/
RUN a2ensite joomla
RUN a2dissite 000-default

# Set root password to access through ssh
RUN echo "root:desdemona" | chpasswd

# Expose web and ssh
EXPOSE 80
EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
