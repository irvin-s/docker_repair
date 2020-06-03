FROM node:alpine  
  
RUN mkdir /app  
WORKDIR /app  
COPY package.json .  
COPY package-lock.json .  
RUN npm install -s --prod  
COPY . .  
  
ENTRYPOINT ["bin/client"]

