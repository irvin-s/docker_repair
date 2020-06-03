FROM mhart/alpine-node  
  
WORKDIR /app  
ADD . .  
  
# If you have native dependencies, you'll need extra tools  
# RUN apk add --no-cache make gcc g++ python  
# If you need npm, don't use a base tag  
RUN npm install --production && npm run build  
  
EXPOSE 3000  
CMD ["npm", "start"]  

