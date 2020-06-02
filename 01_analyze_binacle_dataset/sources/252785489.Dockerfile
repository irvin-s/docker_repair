FROM comaes/storm-base  
  
ADD start.sh /  
  
EXPOSE 8080  
WORKDIR /opt/apache-storm  
  
ENTRYPOINT ["/start.sh"]  

