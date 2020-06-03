FROM node:9.5  
COPY . /app  
  
RUN cd /app && npm install  
  
WORKDIR "/app"  
  
CMD [ "node", "bot.js" ]

