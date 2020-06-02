FROM node:6.5.0  
RUN npm install -g uglify-js  
ENTRYPOINT ["/bin/bash","-c"]  

