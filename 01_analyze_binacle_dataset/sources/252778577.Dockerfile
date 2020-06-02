FROM mhart/alpine-node:9  
# Ensure application code makes it into the /app directory  
COPY ./ /app/  
  
WORKDIR /app  
  
RUN export NODE_ENV=production && npm install  
  
ENTRYPOINT ["./bin/start"]  
  

