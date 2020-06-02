FROM demiyo/core  
MAINTAINER demiyo  
  
ADD . /setup  
  
RUN chmod +x /setup/*.sh && \  
/setup/install.sh && \  
/setup/cleanup.sh  
  
CMD ["/sbin/my_init"]  
  
WORKDIR /data  
  
VOLUME /data  
  
EXPOSE 3389

