FROM mhart/alpine-node:6.7  
MAINTAINER Eagle Chen <chygr1234@gmail.com>  
  
EXPOSE 13001  
WORKDIR /app  
  
COPY package.json /app/  
RUN npm install  
COPY server.js sig.js /app/  
  
CMD ["/usr/bin/npm", "run", "start"]  

