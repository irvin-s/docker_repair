FROM ubuntu:14.04  
MAINTAINER neil@ngrogan.com  
  
ENV DIRPATH /data  
ENV INSTALL_PKGS git vim linux-headers-generic build-essential  
  
RUN sudo apt-get update && \  
sudo apt-get install -y $INSTALL_PKGS  
  
WORKDIR $DIRPATH  
  
VOLUME $DIRPATH  
  
CMD ["/bin/bash"]  
  

