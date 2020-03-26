FROM debian:jessie  
  
RUN apt-get update -q && \  
apt-get install -qy cron mysql-client && \  
apt-get clean -q  
  
ADD optimize.sh /optimize.sh  
ADD run.sh /run.sh  
  
ENV CRON_TIME="0 1,9,17 * * *"  
ENV MYSQL_HOST="mysql"  
ENV MYSQL_PORT="3306"  
ENV MYSQL_PASSWORD="root"  
ENV MYSQL_USERNAME="root"  
ENV MYSQLCHECK_OPTS="-Aos"  
CMD ["/run.sh"]  

