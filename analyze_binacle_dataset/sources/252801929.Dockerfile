FROM node  
  
MAINTAINER 'Edwin Joassart <edwin@3kd.be>'  
ADD ./ /usr/src/app  
WORKDIR /usr/src/app  
  
RUN npm install  
  
RUN npm install --silent -g grunt-cli bower  
  
RUN bower --allow-root install  
RUN grunt  
  
WORKDIR /usr/src/app  
  
EXPOSE 3000  
CMD [ "node", "main.js" ]

