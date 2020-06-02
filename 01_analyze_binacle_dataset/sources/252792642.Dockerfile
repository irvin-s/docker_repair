FROM java:openjdk-8-jre  
  
MAINTAINER jonechenug <jonechenug@gmail.com>  
  
RUN apt-get update  
  
RUN apt-get install libpcap-dev -y  
RUN apt-get install iptables -y  
RUN apt-get clean  
  
ARG source=.  
WORKDIR /fs  
  
COPY $source .  
  
EXPOSE 1099  
EXPOSE 2200  
CMD ["sh", "-c", "java -jar client.jar -b"]  

