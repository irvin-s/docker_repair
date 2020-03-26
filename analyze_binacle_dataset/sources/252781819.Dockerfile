FROM ubuntu:latest  
LABEL org.freenas.autostart="false" \  
org.freenas.interactive="false" \  
org.freenas.version="Latest" \  
org.freenas.upgradeable="true" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Config storage space\" \  
} \  
]"  
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y python-pip  
RUN pip install shreddit  
  
VOLUME /config  
WORKDIR /config  
  
CMD ["shreddit"]  

