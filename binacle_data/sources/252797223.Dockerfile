# Git clone  
FROM ubuntu:15.04  
MAINTAINER Nick Zahn <hi@cloudunder.io>  
  
RUN mkdir ~/.ssh && \  
chmod 0700 ~/.ssh && \  
apt-get update && \  
apt-get install -y git && \  
rm -rf /var/lib/apt/lists/*  
  
COPY ssh-config /root/.ssh/config  
  
WORKDIR /code  
  
CMD cp /custom/id_rsa ~/.ssh/id_rsa && \  
git clone \--branch "${BRANCH}" \--depth 1 ${REPOSITORY} /code && \  
git checkout -qf ${COMMIT}  

