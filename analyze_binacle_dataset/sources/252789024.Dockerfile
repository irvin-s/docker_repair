FROM drupalci/db-base  
MAINTAINER drupalci  
  
# Packages.  
RUN apt-get -y install mysql-server netcat  
  
RUN apt-get clean && apt-get autoclean && apt-get -y autoremove  
  
COPY ./conf/my.cnf /etc/mysql/my.cnf  
  
RUN rm -rf /var/lib/mysql/*  
  
USER root  
  
COPY ./conf/startup.sh /opt/startup.sh  
  
CMD ["/bin/bash", "/opt/startup.sh"]  

