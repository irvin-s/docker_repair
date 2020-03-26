FROM ubuntu:16.04  
# Installing dependencies of LinPhone  
RUN apt-get update && \  
apt-get -y install \  
software-properties-common \  
python-software-properties && \  
rm -rf /var/lib/apt/lists/*  
# Installing LinPhone  
RUN add-apt-repository ppa:linphone/release && \  
apt-get update && \  
apt-get -y install linphone && \  
rm -rf /var/lib/apt/lists/*  

