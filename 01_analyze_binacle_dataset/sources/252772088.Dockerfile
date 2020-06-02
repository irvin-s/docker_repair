FROM ubuntu:latest  
  
RUN apt-get update --yes && \  
apt-get install --yes curl git ca-certificates npm && \  
apt-get clean --yes && \  
npm install -g npm@3.3.4 && \  
npm install -g n && \  
n 4.1.0 && \  
npm install --global elm  
  
ENV ELM_HOME /usr/lib/node_modules/elm/share  

