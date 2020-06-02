FROM mhart/alpine-node:latest  
USER root  
  
MAINTAINER Kevin Richter<me@kevinrichter.nl>  
  
WORKDIR /app  
  
COPY . .  
  
RUN apk add \--no-cache make gcc g++ python  
RUN npm install \--only=production --no-package-lock  
  
ENV MONGO_HOST=localhost  
EXPOSE 3000  
  
CMD ["npm", "start"]  

