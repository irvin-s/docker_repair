FROM ubuntu:14.04  
MAINTAINER Dennis Hazelett "dennis.hazelett@csmc.edu"  
RUN DEBIAN_FRONTEND=noninteractive apt-get update  
RUN apt-get install -y git build-essential  
  
RUN useradd -m user1  
RUN chown -R user1:staff /home/user1  
  
## install dependencies for MUSIC  
## download and install MUSIC software  
RUN su user1  
RUN cd /home/user1 \  
&& git clone https://github.com/gersteinlab/MUSIC \  
&& cd /home/user1/MUSIC \  
&& make clean \  
&& make  
  
# && echo "PATH=$PATH:/home/user1/homer/MUSIC" >> /home/user1/.bashrc  

