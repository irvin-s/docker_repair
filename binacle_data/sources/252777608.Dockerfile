FROM mysql:5.5.44  
MAINTAINER Anthony K GROSS<anthony.k.gross@gmail.com>  
  
WORKDIR /src  
  
ENV MYSQL_MAX_CONNEXIONS "200"  
RUN mv /entrypoint.sh /mysql-entrypoint.sh  
COPY entrypoint.sh /entrypoint.sh  
  
RUN apt-get update -y && \  
apt-get upgrade -y && \  
apt-get install -y supervisor cron && \  
rm -rf /var/lib/apt/lists/* && \  
apt-get autoremove -y --purge && \  
mkdir /logs -p && \  
chmod 777 /logs -Rf && \  
chmod 777 /src -Rf && \  
usermod -u 1000 mysql && \  
mkdir -p /var/run/mysqld && \  
chmod -R 777 /var/run/mysqld && \  
chmod +x /entrypoint.sh  
  
COPY conf/mysql/my.cnf /etc/mysql/my.cnf  
COPY conf/cron.conf /etc/cron.d/cron-mysql.conf  
COPY conf/supervisor.conf /etc/supervisor/conf.d/supervisor.conf  
COPY scripts /scripts  
  
RUN sh /entrypoint.sh install  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["run"]

