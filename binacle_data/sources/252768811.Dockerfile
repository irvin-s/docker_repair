FROM mhart/alpine-node:6  
WORKDIR /src  
ADD . .  
RUN npm install  
  
CMD ["node", "index.js"]

