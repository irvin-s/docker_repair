FROM fstehle/rpi-homebridge  
RUN [ "cross-build-start" ]  
  
ADD docker-run.sh /usr/bin/docker-run  
RUN npm install -g --unsafe-perm homebridge-particle  
  
RUN [ "cross-build-end" ]  
  
EXPOSE 5353 51826  
CMD ["/usr/bin/docker-run"]  

