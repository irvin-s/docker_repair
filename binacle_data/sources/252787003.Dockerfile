FROM node:8  
LABEL maintainer="Brahman <brahmnan@gmail.com>"  
  
RUN apt-get update && apt-get install -y mc nano  
RUN npm install pm2 -g  
  
VOLUME ["/app"]  
  
# Expose ports  
EXPOSE 8080  
WORKDIR /app  
  
# Start process.yml  
CMD ["pm2-docker", "server.js"]

