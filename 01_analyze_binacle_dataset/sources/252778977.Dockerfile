FROM groovy:2.4.11-jre8-alpine  
  
MAINTAINER Zachary Joyner zachary.joyner@cloudbees.com  
  
WORKDIR /home/groovy  
  
ADD EStoInflux.groovy /home/groovy/EStoInflux.groovy  
  
ADD SendESDataWithADelay.sh /home/groovy/SendESDataWithADelay.sh  
  
ENTRYPOINT ["/home/groovy/SendESDataWithADelay.sh", "30"]  
  

