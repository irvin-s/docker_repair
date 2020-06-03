FROM ubuntu:latest  
MAINTAINER Borna Arzi <bornaarzi@gmail.com>  
RUN apt-get -y update  
RUN apt-get install -y default-jdk  
ADD ./apache-tomcat-8.5.15 /root/apache-tomcat-8.5.15  
ADD ./hsqldb-2.4.0 /root/hsqldb-2.4.0  
ADD ./scripts/start.sh /start.sh  
RUN chmod 777 /start.sh  
RUN chmod 777 /root/apache-tomcat-8.5.15/bin/startup.sh  
RUN chmod 777 /root/apache-tomcat-8.5.15/bin/catalina.sh  
CMD ["/bin/bash", "/start.sh"]  

