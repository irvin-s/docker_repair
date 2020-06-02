FROM duffqiu/activemq-hub:5.12-snapshot  
MAINTAINER duffqiu@gmail.com  
  
ADD bin/start.sh /activemq/bin/start.sh  
RUN chmod +x /activemq/bin/start.sh  
  
ADD conf/activemq.xml /activemq/conf/activemq.xml.tmp  
  
EXPOSE 61616 61619 61613 61614 5672 1883  
EXPOSE 61626 61629 61623 61624 5682 1893  
EXPOSE 61636 61639 61633 61634 5692 1903  
WORKDIR /activemq  
  
ENTRYPOINT [ "/activemq/bin/start.sh" ]  

