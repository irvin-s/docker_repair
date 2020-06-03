FROM ubuntu:14.04  
MAINTAINER avadhutp  
  
LABEL description="Enjoy lazarus. Plays music on running."  
  
# Install basic dependencies  
RUN \  
apt-get update && \  
apt-get install -y golang vlc git python-pip && \  
pip install -U youtube-dl && \  
mkdir /gocode  
  
# Set paths  
ENV GOPATH /gocode  
ENV PATH /gocode/bin:$PATH  
  
# Put in lazarus pre-requisites  
RUN \  
mkdir /tmp/lazarus && \  
touch /etc/lazarus.ini && \  
echo "tmp_location = /tmp/lazarus/" >> /etc/lazarus.ini && \  
echo "player_cmd = cvlc --play-and-exit" >> /etc/lazarus.ini  
  

