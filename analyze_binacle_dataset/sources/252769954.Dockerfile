FROM dockerfile/nodejs  
RUN npm install -g frisby  
RUN npm install -g jasmine-node  
ENV NODE_PATH /usr/local/lib/node_modules/  

