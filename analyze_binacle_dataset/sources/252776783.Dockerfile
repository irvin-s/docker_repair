FROM debian:jessie  
MAINTAINER Christophe Burki, christophe.burki@gmail.com  
  
# Install system requirements  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y \  
apache2-mpm-prefork \  
curl \  
libapache2-mod-php5 \  
locales \  
mysql-client \  
php5-gd \  
php5-mysql \  
phpmyadmin \  
python-pip \  
pwgen  
  
# Configure locales and timezone  
RUN locale-gen en_US.UTF-8  
RUN locale-gen en_GB.UTF-8  
RUN locale-gen fr_CH.UTF-8  
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime  
RUN echo "Europe/Zurich" > /etc/timezone  
  
# Phpmyadmin config  
RUN sed -i "s/\$dbserver=''/\$dbserver='db'/g" /etc/phpmyadmin/config-db.php  
  
# Supervisor config  
RUN mkdir /var/log/supervisor  
RUN pip install supervisor  
COPY configs/supervisord.conf /etc/supervisord.conf  
  
# Startup script  
COPY scripts/start.sh /opt/start.sh  
RUN chmod 755 /opt/start.sh  
  
RUN mkdir -p /data/var  
  
EXPOSE 80  
CMD ["/opt/start.sh"]  

