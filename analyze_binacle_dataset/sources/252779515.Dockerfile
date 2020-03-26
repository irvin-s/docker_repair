FROM mhart/alpine-node:6.3  
WORKDIR /src  
  
ADD package.json ./  
RUN ["npm", "install"]  
ADD . .  
  
ENTRYPOINT ["npm", "start"]  
EXPOSE 3000  

