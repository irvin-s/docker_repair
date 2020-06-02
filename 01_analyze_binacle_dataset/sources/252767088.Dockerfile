FROM node:6  
WORKDIR /app  
  
RUN apt-get update && apt-get install tree  
  
COPY package.json package.json  
RUN npm i  
  
RUN mkdir src  
  
COPY start.sh start.sh  
RUN chmod +x start.sh  
  
COPY webpack.config.js .  
  
COPY index.js index.js  
  
CMD ["node", "index.js"]  
  
EXPOSE 9001  

