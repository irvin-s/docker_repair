FROM blacklabelops/rust-server  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
vim && \  
rm -rf /var/lib/apt/lists/*  
  
# Setup restart support (for update automation)  
ADD restart_app/ /restart_app/  
WORKDIR /restart_app  
RUN npm install  
  
COPY docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
WORKDIR /steamcmd/rust  
CMD ["rust"]  

