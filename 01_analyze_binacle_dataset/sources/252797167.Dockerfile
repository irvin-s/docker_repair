FROM ubuntu:14.04  
MAINTAINER Erik Osterman "e@osterman.com"  
ENV DEBIAN_FRONTEND noninteractive  
ENV GIT_REPO https://github.com/osterman/IRCD-Balancer.git  
  
ENV IRC_CONFIG "/lb/config.js"  
ENV IRC_SERVER "ircd"  
ENV IRC_PORT 6667  
ENV IRC_PASSWORD "password"  
WORKDIR /  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends git nodejs ca-certificates && \  
ln -s /usr/bin/nodejs /usr/bin/node && \  
apt-get clean  
  
RUN git clone $GIT_REPO /lb && \  
cp /lb/contrib/config.js.example /lb/config.js && \  
rm -rf /lb/.git  
  
WORKDIR /lb  
  
EXPOSE 6667  
ENTRYPOINT ["node", "/lb/ircdbalancer.js"]  

