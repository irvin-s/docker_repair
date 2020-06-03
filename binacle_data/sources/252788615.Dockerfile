FROM ubuntu:16.04  
RUN rm -rf /etc/localtime &&\  
ln -s /usr/share/zoneinfo/Europe/Budapest /etc/localtime &&\  
apt-get update &&\  
apt-get upgrade -y &&\  
apt-get install -y locales language-pack-en-base &&\  
rm -rf /var/lib/apt/lists/*  
ENV LC_ALL en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LC_CTYPE en_US.UTF-8  
ENV LANGUAGE en_US:en  
RUN locale-gen en_US.UTF-8  
CMD ["/bin/bash"]  

