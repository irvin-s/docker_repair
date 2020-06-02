#  
# hubot Dockerfile  
# https://github.com/almat64/dockerfile-hubot  
#  
# Base image  
FROM dockerfile/nodejs  
  
#MAINTAINER ALMAT <almat.cpp@gmail.com>  
# Import deploy key  
RUN mkdir -p /root/.ssh  
ADD id_rsa /root/.ssh/id_rsa  
RUN chmod 700 /root/.ssh/id_rsa  
ADD ssh_config /root/.ssh/config  
  
RUN \  
git clone git@github.com:almat64/hubot.git /hubot && \  
cd /hubot && \  
git checkout slack && \  
git submodule update && \  
npm install && \  
rm -rf .git scripts/.git && \  
useradd hubot --home /hubot  
  
ADD start.sh /hubot-start  
  
ENV NODE_ENV production  
  
VOLUME ["/data", "/hubot-override"]  
  
WORKDIR /hubot  
  
CMD ["bash", "/hubot-start"]  
  
EXPOSE 8080  

