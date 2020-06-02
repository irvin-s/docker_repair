FROM ubuntu:16.04  
# Install the required packages  
RUN apt-get update && \  
apt-get -y install babeld && \  
rm -rf /var/lib/apt/lists/*  
# Optional, only for troubleshooting  
RUN apt-get update && \  
apt-get -y install \  
iproute2 \  
nano \  
ssh \  
tcpdump \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN /etc/init.d/babeld restart  

