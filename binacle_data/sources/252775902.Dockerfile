# Pull Tuxedo base image  
FROM bluezd/tuxedo:12.2.2  
  
MAINTAINER Todd Little <todd.little@oracle.com>  
COPY simpapp_runme.sh /home/oracle/  
  
USER root  
RUN chown oracle:oracle -R /home/oracle  
#RUN yum install vim -y  
  
USER oracle  
WORKDIR /home/oracle  
  
#CMD ["sh", "-x", "/home/oracle/simpapp_runme.sh"]  
CMD ["/home/oracle/simpapp_runme.sh"]  

