FROM node:5  
RUN npm install -g npm_lazy  
COPY config.js /  
CMD npm_lazy --config /config.js  

