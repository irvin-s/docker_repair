FROM phusion/baseimage  
  
RUN apt-get update && apt-get upgrade -y && apt-get install -y \  
doom-wad-shareware  
EXPOSE 2432/udp  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
ENTRYPOINT ["/start.sh"]  

