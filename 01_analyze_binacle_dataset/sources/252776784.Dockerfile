FROM debian:jessie  
MAINTAINER Christophe Burki, christophe.burki@gmail.com  
  
# Install system requirements  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y \  
locales \  
mysql-client \  
mysql-server \  
python-pip \  
pwgen  
  
# Configure locales and timezone  
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 fr_CH.UTF-8  
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime  
RUN echo "Europe/Zurich" > /etc/timezone  
  
# MySQL config  
COPY configs/my.cnf /etc/mysql/conf.d/my.cnf  
RUN chmod 664 /etc/mysql/conf.d/my.cnf  
  
# Supervisor config  
RUN mkdir /var/log/supervisor  
RUN pip install supervisor  
COPY configs/supervisord.conf /etc/supervisord.conf  
  
# Startup script  
COPY scripts/start.sh /opt/start.sh  
RUN chmod 755 /opt/start.sh  
  
EXPOSE 3306  
CMD ["/opt/start.sh"]  

