from alrighttheresham/centos-base  
  
RUN yum -y install mysql-server  
  
ADD ./startup.sh /opt/startup.sh  
  
EXPOSE 3306  
CMD ["/bin/bash", "/opt/startup.sh"]  

