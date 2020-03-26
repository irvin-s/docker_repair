FROM node:alpine  
COPY . /root  
WORKDIR /root  
RUN npm install && npm run build  
CMD node build/index  

