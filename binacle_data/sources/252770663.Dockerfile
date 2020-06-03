FROM debian:jessie  
MAINTAINER AX Carpentry  
  
RUN apt-get update && apt-get install -y mosquitto  
RUN apt-get install -y vim  
  
EXPOSE 1883  
ENTRYPOINT "mosquitto"  
CMD ["-c", "/etc/mosquitto/mosquitto.conf"]  

