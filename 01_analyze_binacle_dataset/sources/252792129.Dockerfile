FROM chastell/trusty  
  
MAINTAINER Piotr Szotkowski <chastell@chastell.net>  
  
RUN apt-get update  
RUN apt-get install --assume-yes pwgen postgresql  
RUN apt-get clean  
  
RUN rm --force --recursive /var/lib/postgresql  
  
ADD files/etc /etc  
ADD files/usr /usr  
  
VOLUME /var/lib/postgresql  
  
EXPOSE 5432  
CMD /usr/local/bin/setup_and_start_postgresql.sh  

