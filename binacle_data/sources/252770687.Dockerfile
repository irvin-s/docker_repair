FROM node:9-alpine  
RUN npm install tap-xunit@2.2.0  
ENTRYPOINT /node_modules/tap-xunit/bin/tap-xunit  

