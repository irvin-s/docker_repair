FROM crowsnest/storm-base:1.0.2  
MAINTAINER Josh Sorenson <josh@crowsnest.io>  
  
ADD start.sh /  
  
EXPOSE 6700 6701 6702 6703  
WORKDIR /opt/apache-storm  
  
ENTRYPOINT ["/start.sh"]  

