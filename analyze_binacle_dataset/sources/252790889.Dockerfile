FROM linuxserver/baseimage.python  
MAINTAINER lonix <lonix@linuxserver.io  
  
ENV PYTHONIOENCODING="UTF-8"  
#Adding Custom files  
COPY init/ /etc/my_init.d/  
COPY services/ /etc/service/  
COPY defaults/ /defaults  
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh  
  
#Volumes and Ports  
EXPOSE 5299  
VOLUME ["/config", "/downloads", "/books"]  
  

