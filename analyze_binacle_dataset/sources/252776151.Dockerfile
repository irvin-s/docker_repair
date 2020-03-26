FROM node:boron  
  
WORKDIR /data/  
COPY package.json /data/  
RUN npm install  
COPY bot.js config.js /data/  
RUN chmod +x ./bot.js  
  
ENV TZ=America/Chicago  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
CMD ["node", "./bot.js"]  
  

