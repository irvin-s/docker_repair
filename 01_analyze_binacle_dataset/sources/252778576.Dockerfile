FROM mhart/alpine-node:10  
# Ensure application code makes it into the /app directory  
COPY ./ /app/  
  
WORKDIR /app  
  
RUN export NODE_ENV=production && npm install  
  
ENTRYPOINT ["/usr/bin/node", "index.js"]  
  

