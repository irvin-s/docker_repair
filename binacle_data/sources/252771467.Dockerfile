FROM akadan47/ubuntu:14.04  
# Install.  
RUN \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get install -y python3-pip && \  
pip3 install --upgrade pip && \  
ln -s /usr/bin/python3 /usr/bin/python && \  
rm -rf /var/lib/apt/lists/*  
  
CMD ["bash"]

