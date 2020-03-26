FROM ubuntu:17.04  
MAINTAINER Muhammad Ebraheem <muhaeb@gmail.com>  
  
RUN apt-get update -qq && \  
apt-get install -y \  
mono-complete wget build-essential unzip sudo && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
WORKDIR /root  
  
COPY / /root/  
  
RUN ./install.sh  
  
ENTRYPOINT ["/root/run.sh"]  

