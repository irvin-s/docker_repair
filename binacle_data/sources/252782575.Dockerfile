FROM debian:jessie  
  
ENV TERM xterm  
ENV DEBIAN_FRONTEND noninteractive  
  
## Set LOCALE to UTF8 ##  
RUN apt-get update && apt-get install -y locales  
RUN echo "es_ES.UTF-8 UTF-8" > /etc/locale.gen && \  
locale-gen es_ES.UTF-8 && \  
dpkg-reconfigure locales && \  
/usr/sbin/update-locale LANG=es_ES.UTF-8  
ENV LC_ALL es_ES.UTF-8  
COPY entry.sh /  
RUN chmod +x entry.sh  
  
RUN groupadd -g 983 postgres  
RUN useradd -g 983 -u 984 -Md / -s /bin/bash postgres  
  
RUN mkdir -p /opt/alfresco-5.0.a  
RUN mkdir -p /hdd/alfresco-5.0.a  
  
VOLUME /opt/alfresco-5.0.a  
VOLUME /hdd/alfresco-5.0.a  
  
EXPOSE 8473  
ENTRYPOINT /entry.sh  

