FROM concretesolutions/ubuntu-dev  
  
# Install Python  
RUN apt-get update &&\  
apt-get install -y python python-dev python-pip python-virtualenv &&\  
apt-get clean && rm -rf /var/lib/apt/lists/*  

