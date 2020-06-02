FROM peelsky/zulu-openjdk-busybox  
MAINTAINER Arthur Tsang <arthur_tsang@hotmail.com>  
  
WORKDIR /app  
  
ADD ./turbine-executable-2.0.0-DP.3-SNAPSHOT.jar /app/turbine.jar  
  
EXPOSE 8000  
CMD java -jar turbine.jar --port 8000 --streams $TURBINE_STREAMS  

