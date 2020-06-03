FROM ubuntu:16.04  
MAINTAINER Matthias Leuffen <leuffen@continue.de>  
MAINTAINER Laurenz Gohr <gohr@continue.de>  
  
  
ARG SKIP_COMPOSER_UPDATE="0"  
# Install deps  
WORKDIR /root/  
  
ADD .docker/.dockerfile-install.sh /root/  
RUN chmod 755 /root/.dockerfile-install.sh  
RUN /root/.dockerfile-install.sh  
  
# Aktuelles Projektverzeichnis nach /opt kopieren  
ADD / /opt/  
  
ADD .docker/.dockerfile-configure.sh /root/  
RUN chmod 755 /root/.dockerfile-configure.sh  
RUN /root/.dockerfile-configure.sh $SKIP_COMPOSER_UPDATE  
  
ADD .docker/ /root/  
  
# Entry Hinzufügen  
ADD .docker/entry.sh /root/  
RUN chmod 755 /root/entry.sh  
  
EXPOSE 62111/udp  
EXPOSE 80/tcp  
  
ENTRYPOINT ["/root/entry.sh"]  

