FROM ubuntu:latest  
  
MAINTAINER Mike Weaver <>  
  
VOLUME ["/starbound"]  
  
COPY start.sh /start.sh  
  
RUN apt-get update \  
&& apt-get install lib32gcc1 libpng12-0 -y \  
&& mkdir -p /starbound \  
&& chmod +x /start.sh  
  
EXPOSE 21025  
EXPOSE 21026  
CMD /start.sh  

