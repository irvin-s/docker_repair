FROM tutum/mysql:5.6  
MAINTAINER Bharat Akkinepalli <bharatak@thoughtworks.com>  
ENV REFRESHED_AT 2015-05-04T11:25  
ENV MYSQL_ROOT_PASSWORD password  
  
ADD mysql_backup.sql.tar.gz /tmp/  
RUN chown root:root /tmp/mysql_backup.sql  
  
VOLUME [ "/backup" ]  

