FROM darrenfang/hexo  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get -y install \  
apt-transport-https \  
ca-certificates \  
curl \  
software-properties-common && \  
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add \- && \  
add-apt-repository \  
"deb [arch=amd64] https://download.docker.com/linux/debian \  
$(lsb_release -cs) \  
stable" && \  
apt-get update && \  
apt-get -y install docker-ce  
  
CMD [ "node" ]  

