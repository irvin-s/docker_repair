FROM ubuntu:artful  
  
RUN apt update \  
&& apt install ffmpeg -y \  
&& rm /var/lib/apt/lists/* /var/log/* -Rf  
  
ADD script.sh /  
  
VOLUME ["/music"]  
  
WORKDIR /music  
  
ENTRYPOINT ["/bin/sh", "/script.sh"]  

