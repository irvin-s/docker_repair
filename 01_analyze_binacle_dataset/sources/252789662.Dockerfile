FROM node:6.3-wheezy  
  
RUN apt-get update && apt-get install -y wget openjdk-7-jdk --fix-missing  
RUN npm install -g pnpm  

