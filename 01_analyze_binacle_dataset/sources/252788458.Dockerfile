FROM crowsnest/storm-base:1.0.1  
MAINTAINER Josh Sorenson <josh@crowsnest.io>  
  
ADD start.sh /  
  
EXPOSE 3772 6627  
WORKDIR /opt/apache-storm  
  
ENTRYPOINT ["/start.sh"]  

