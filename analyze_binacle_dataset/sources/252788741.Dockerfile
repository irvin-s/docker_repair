FROM node:7  
RUN apt-get update && apt-get install -y graphicsmagick && apt-get clean  
  
RUN mkdir -p /opt/skins  
WORKDIR /opt/skins  
  
ADD . .  
  
RUN yarn  
  
CMD npm rebuild && yarn start  

