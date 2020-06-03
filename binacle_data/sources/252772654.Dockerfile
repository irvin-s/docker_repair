FROM ghost  
MAINTAINER Tim Bennett  
  
# Setup nc  
RUN \  
apt-get update && \  
apt-get install -y netcat  
  
# Clean up  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY wait-mysql.sh /wait-mysql.sh  
RUN chmod +x /wait-mysql.sh  
  
# Database connection details  
ENV MYSQL_HOST=mysql  
ENV MYSQL_PORT=3306  
# How many times to try to connect to mysql before giving up  
ENV WAIT_LOOPS=10  
# Sleep time between each try  
ENV WAIT_SLEEP=2  
ENTRYPOINT ["/wait-mysql.sh"]  
  
CMD ["npm", "start"]

