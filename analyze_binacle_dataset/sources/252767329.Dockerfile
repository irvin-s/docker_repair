# alexindigo/docker-proxy-npm  
FROM alexindigo/node-app  
MAINTAINER Alex Indigo <iam@alexindigo.com>  
  
ENV KAPPA_VERSION v1.0.0-rc.14  
# Install kappa  
RUN npm install -g kappa@${KAPPA_VERSION} good@^3 good-console@^2  
  

