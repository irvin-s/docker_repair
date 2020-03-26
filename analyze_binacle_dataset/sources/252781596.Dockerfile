FROM mhart/alpine-node:5  
WORKDIR /src  
ADD . .  
  
RUN apk add --no-cache make gcc g++ python  
  
RUN npm install --only=prod  
  
EXPOSE 8000  
CMD ["npm", "start"]  

