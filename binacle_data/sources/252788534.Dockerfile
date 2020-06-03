FROM ubuntu:16.04  
MAINTAINER Cryptomental "cryptomental.com@gmail.com"  
# Install latest steem-piston package and its dependencies  
RUN apt-get update -y  
RUN apt-get install -y python3-dev build-essential python3-pip libssl-dev  
RUN pip3 install steem-piston --upgrade  
  
# Piston user environment  
ENV PISTON_USER piston  
ENV PISTON_HOME /home/piston  
  
RUN useradd -m $PISTON_USER && chown -R $PISTON_USER $PISTON_HOME  
  
# Use bash as default shell  
RUN ln -sf bash /bin/sh  
  
# Set entrypoint  
USER $PISTON_USER  
WORKDIR $PISTON_HOME  
ENTRYPOINT ["bash"]  
  

