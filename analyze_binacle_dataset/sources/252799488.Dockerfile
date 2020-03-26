FROM node:8-alpine  
  
RUN apk update && \  
apk add tzdata && \  
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \  
echo "Asia/Shanghai" > /etc/timezone && \  
date  
  
ADD ./ /weather/  
  
WORKDIR /weather  
  
RUN npm install  
  
ENTRYPOINT ["node", "index.js"]  

