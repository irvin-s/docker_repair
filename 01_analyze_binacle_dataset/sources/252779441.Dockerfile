FROM java:8  
RUN \  
export DEBIAN_FRONTEND=noninteractive && \  
sed -i 's/# \\(.*multiverse$\\)/\1/g' /etc/apt/sources.list && \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get install -y vim wget curl git maven  
  
VOLUME /volume/git  
  
RUN mkdir -p /local/git  
WORKDIR /local/git  
  
CMD ["/bin/bash"]

