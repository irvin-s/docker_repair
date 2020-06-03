FROM dhoer/flyway:latest  
  
WORKDIR /aws  
  
RUN \  
apt-get update && \  
apt-get install -y python-pip --no-install-recommends && \  
pip install awscli && \  
rm -rf /var/lib/apt/lists/*  
  
  
ENTRYPOINT ["flyway"]  
  
  

