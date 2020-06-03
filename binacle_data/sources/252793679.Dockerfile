FROM ubuntu:16.04  
RUN apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mumble-server  
  
ADD start.sh /  
ADD mumble-server.ini /  
RUN chmod +x /start.sh  
  
EXPOSE 64738  
CMD ["/start.sh"]  

