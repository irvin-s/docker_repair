# Some Dpocker installation  
# Here you see a limesurves Docker as an example  
# VERSION 1.0  
#  
FROM mysql:5.7  
MAINTAINER Lukas Pessl  
  
ADD scripts /opt/scripts  
WORKDIR /opt/scripts  
RUN chmod a+x *.sh  
  
EXPOSE 3306  
CMD ["mysqld"]  
  

