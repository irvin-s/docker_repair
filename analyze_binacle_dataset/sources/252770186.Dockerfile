FROM node:7-alpine  
  
WORKDIR /root  
  
RUN apk --no-cache add curl git  
  
COPY package.json .  
RUN npm install  
  
COPY bin bin/  
COPY lib lib/  
  
ENTRYPOINT ["npm", "start", "-s"]  
  
EXPOSE 2375  

