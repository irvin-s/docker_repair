FROM burningswell/core:0.0.46  
MAINTAINER Roman Scherer <roman@burningswell.com>  
  
ENV LEIN_ROOT 1  
ADD . /opt/burningswell/worker  
WORKDIR /opt/burningswell/worker  
  
RUN lein uberjar  
CMD ["java", "-jar", "target/burningswell-worker.jar"]  

