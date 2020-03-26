FROM node:8-slim  
  
RUN apt-get update && \  
apt-get install -y \  
libgtk2.0-0 \  
libnotify-dev \  
libgconf-2-4 \  
libnss3 \  
libxss1 \  
libasound2 \  
xvfb && \  
yarn global add cypress && \  
rm -rf /var/lib/apt/lists/* /var/apt/cache/* /tmp/* && \  
yarn cache clean  
  

