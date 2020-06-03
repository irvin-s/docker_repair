FROM mhart/alpine-node:6  
WORKDIR /src  
ADD . .  
  
RUN npm install --production  
  
EXPOSE 5000  
CMD ["npm", "start"]  

