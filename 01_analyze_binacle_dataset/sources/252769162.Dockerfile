FROM debian:stretch  
  
LABEL maintainer Hassan Amouhzi  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install dev tools  
RUN apt-get update && apt-get install -y \  
apt-utils \  
bash-completion \  
wget \  
curl \  
lsb-release \  
apt-transport-https \  
git-core \  
sudo \  
make \  
vim \  
nano \  
&& rm -rf /var/lib/apt/lists/*

