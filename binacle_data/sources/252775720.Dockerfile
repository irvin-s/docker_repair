FROM node:0.12.7  
RUN mkdir -p /app  
WORKDIR /app  
  
ENV WORKDIR /app  
  
# install global packages  
RUN npm install -g bower pm2 gulp grunt-cli  
  
CMD ["npm"]

