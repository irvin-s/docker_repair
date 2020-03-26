FROM debian:sid-slim  
  
RUN apt-get update && \  
apt-get install -y \  
radare2 \  
volatility \  
binwalk && \  
  
# Cleanup  
rm -rf /var/lib/apt/lists/*  
  
WORKDIR /workdir  
  
# Add local files  
ADD ./bash_tweaks/* /root/  
RUN mv /root/motd /etc/motd  
ADD ./configs/.radare2rc /root/  
ADD entrypoint.sh /opt/  
  
ENTRYPOINT /opt/entrypoint.sh  

