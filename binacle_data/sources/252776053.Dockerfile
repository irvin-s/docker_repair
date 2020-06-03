FROM node:latest  
  
WORKDIR /home/node  
RUN apt-get update && apt-get install -y libicu-dev  
  
ADD ./discord-irc /home/node  
RUN npm install  
RUN npm run build  
  
CMD npm start -- --config /config.json  

