FROM ubuntu:xenial  
RUN apt-get update && apt-get install -y \  
git \  
jq \  
silversearcher-ag \  
tmux \  
vim  

