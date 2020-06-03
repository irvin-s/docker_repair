FROM debian:stretch-slim  
  
RUN apt-get update && \  
apt-get install -y devscripts cargo && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/*  
  
COPY run.sh /  
  
ENTRYPOINT ["/run.sh"]  

