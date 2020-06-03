FROM ubuntu:16.04  
LABEL maintainer="Matthias Leuffen <leuffen@continue.de>"  
  
ADD / /root/flavor/  
RUN /root/flavor/installer-debian.sh  
  
ENV TIMEZONE Europe/Berlin  
ENV KICKSTART_HYPERVISE_HOST="http://kickstart-hypervise/"  
ENV HTTP_HOST "4200"  
ENV DEV_MODE "0"  
ENV DEV_CONTAINER_NAME "unnamed"  
ENV DEV_UID "1000"  
ENV DEV_TTYID "xXx"  
EXPOSE 80 4200  
ENTRYPOINT ["/kickstart/container/start.sh"]  

