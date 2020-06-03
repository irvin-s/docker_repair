FROM chastell/trusty  
  
MAINTAINER Piotr Szotkowski <chastell@chastell.net>  
  
RUN apt-get update  
RUN apt-get install --assume-yes mysql-server  
RUN apt-get clean  
  
RUN rm --force --recursive /var/lib/mysql/mysql  
  
ADD files/etc /etc  
ADD files/usr /usr  
  
VOLUME /var/lib/mysql  
  
EXPOSE 3306  
CMD /usr/local/bin/setup_and_start_mysql.sh  

