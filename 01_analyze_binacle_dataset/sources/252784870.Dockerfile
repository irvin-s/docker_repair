FROM mhart/alpine-node:5.11  
ADD . .  
  
# If you have native dependencies, you'll need extra tools  
# RUN apk add --no-cache make gcc g++ python  
# If you need npm, don't use a base tag  
RUN npm install  
  
EXPOSE 4004  
CMD ["node", "app.js"]

