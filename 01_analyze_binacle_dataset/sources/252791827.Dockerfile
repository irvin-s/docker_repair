FROM node:5  
  
RUN useradd -ms /bin/bash node  
ADD . /home/node/app  
RUN chown -R node:node /home/node  
RUN npm install -g npm  
RUN npm install -g typescript@1.7.5 bower gulp node-gyp  
RUN apt-get update && apt-get install -y libkrb5-dev  
  
USER node  
ENV HOME /home/node  
EXPOSE 3003  
VOLUME ["/home/node/app"]  
WORKDIR /home/node/app  
RUN npm install  
WORKDIR /home/node/app/public  
RUN bower install  
WORKDIR /home/node/app  
RUN tsc  
CMD node server.js  

