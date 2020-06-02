FROM node:0.12.9  
RUN mkdir -p /app  
WORKDIR /app  
ONBUILD ADD . /app  
ONBUILD RUN npm install -g bower  
ONBUILD RUN npm install  
ONBUILD RUN bower install --allow-root --config-interactive=false  
  
CMD [ "npm", "start" ]

