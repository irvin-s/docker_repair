FROM rancher/agent:v0.8.2  
MAINTAINER Daniel Bodnar daniel.bodnar@gmail.com  
COPY start.sh /start.sh  
ENTRYPOINT ["/start.sh"]  

