FROM crowsnest/storm-base:1.0.2  
MAINTAINER Josh Sorenson <josh@crowsnest.io>  
  
ADD start.sh /  
  
EXPOSE 6699  
WORKDIR /opt/apache-storm  
  
ENTRYPOINT ["/start.sh"]  

