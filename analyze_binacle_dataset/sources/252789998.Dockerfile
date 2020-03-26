FROM camilin87/node-cron:latest  
  
RUN mkdir -p /usr/src/app  
COPY . /usr/src/app  
  
ENV NPM_COMMAND='cron'  
RUN cd /usr/src/app && npm install  

