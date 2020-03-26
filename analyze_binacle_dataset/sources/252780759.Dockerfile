FROM badele/debian-nodejs  
MAINTAINER Bruno Adelé "bruno@adele.im"  
# Upgrade the distribution  
RUN apt-get update  
RUN apt-get -yf upgrade  
RUN apt-get -yf dist-upgrade  
  
# Install nodered  
RUN npm install -g node-red pm2  
  
# Configure nodered  
RUN pm2 start /usr/bin/node-red -- -v  
RUN pm2 save  
RUN pm2 startup  
  
# Clean the cache and unused packages  
RUN apt-get clean  
RUN apt-get autoremove  
  
EXPOSE 1880  
  
CMD node-red  

