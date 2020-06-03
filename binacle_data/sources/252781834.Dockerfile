FROM node:alpine  
  
RUN mkdir /app  
WORKDIR /app  
COPY package.json .  
RUN npm install -s --prod  
COPY . .  
  
ENV NODE_ENV=production  
  
CMD npm start  
  
HEALTHCHECK CMD wget -q localhost:3000 -O /dev/null || exit 1

