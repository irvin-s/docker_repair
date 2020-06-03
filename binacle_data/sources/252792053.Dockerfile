FROM openjdk  
MAINTAINER liuchibing  
  
COPY P2PerServer.jar ~/P2PerServer.jar  
WORKDIR ~/  
  
CMD java -jar P2PerServer.jar  

