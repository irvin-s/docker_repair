FROM ubuntu-upstart:14.04  
  
RUN apt-get update; apt-get -y upgrade  
RUN apt-get -y purge openssh-server openssh-client ; apt-get -y autoremove  
RUN apt-get -y install vim ufw bind9  
  
COPY . /data/  
RUN ["/data/config.sh"]  

