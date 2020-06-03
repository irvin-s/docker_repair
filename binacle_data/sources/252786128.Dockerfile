FROM ubuntu:latest  
  
EXPOSE 7777-7780  
VOLUME /config  
  
RUN apt-get update && \  
apt-get install -y curl unzip xdg-user-dirs && \  
rm -rf /var/lib/apt/lists/  
  
COPY entrypoint.sh /entrypoint.sh  
COPY update.sh /update.sh  
  
RUN chmod +x /update.sh && \  
chmod +x /entrypoint.sh && \  
sleep 1 && \  
/update.sh  
  
COPY DefaultGame.ini /LinuxServer/  
  
ENTRYPOINT /entrypoint.sh  

