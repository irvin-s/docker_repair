FROM debian:jessie  
  
COPY bin/docker-compose /usr/bin  
  
COPY bin/watchman /usr/bin  
  
RUN mkdir -p /usr/local/var/run/watchman/root-state/state  
  
RUN mkdir -p /var/log/watchman  
  
RUN mkdir -p /etc/watchman  
  
RUN ln -sf /dev/stdout /var/log/watchman/watchman.log  
  
ENTRYPOINT [ "watchman" ]  
  
CMD [ "-f", "--logfile=/var/log/watchman/watchman.log" ]  
  

