FROM mhart/alpine-node  
  
WORKDIR /src  
ADD . .  
  
RUN npm install --production  
  
EXPOSE 3000  
VOLUME "/src"  
  
CMD node index.js  

