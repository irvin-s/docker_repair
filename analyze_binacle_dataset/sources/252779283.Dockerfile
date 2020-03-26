FROM c12e/debian  
ENV SERVICE_NAME=tower-cli  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install python python-pip && \  
pip install ansible-tower-cli && \  
apt-get clean && \  
rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD ["/usr/local/bin/tower-cli"]  

