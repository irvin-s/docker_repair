FROM ryht/ubuntu:lucid  
COPY sources.list /etc/apt/  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get clean && \  
rm -rf /var/cache/apt/archives/*  
CMD ["/bin/sh"]  

