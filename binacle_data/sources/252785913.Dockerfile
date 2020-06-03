# blur-admin base image  
FROM node:6.2.2  
MAINTAINER Darren Everley <darren.everley@sysemia.co.uk>  
  
RUN npm install --global gulp-cli && \  
npm install --global bower  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
COPY bower.json /usr/src/app/  
RUN npm install && \  
bower install -F --allow-root --config.interactive=false  
COPY . /usr/src/app  
  
ENV GULP_COMMAND serve:dist  
  
ENTRYPOINT ["sh", "-c"]  
CMD ["gulp $GULP_COMMAND"]  

