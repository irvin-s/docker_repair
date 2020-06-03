FROM node:8-alpine  
  
RUN apk add --no-cache docker  
  
WORKDIR /usr/src/judge-taskmaster  
  
COPY package.json .  
COPY package-lock.json .  
  
RUN npm install -D  
  
COPY . .  
  
CMD ["npm", "start"]

