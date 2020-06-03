FROM danieldent/debian-jessie-base  
MAINTAINER Daniel Dent (https://www.danieldent.com/)  
RUN /usr/local/bin/install-resilio-sync.sh  
COPY rslsync.conf /etc/  
COPY run_sync /opt/  
  
EXPOSE 8888  
EXPOSE 55555  
VOLUME /mnt/sync  
  
ENTRYPOINT ["/opt/run_sync"]  
CMD ["--log", "--config", "/etc/rslsync.conf"]  

