FROM node:9-alpine  
  
WORKDIR /build  
  
COPY . .  
RUN npm install && npm run export  
  
FROM nginx:alpine  
  
COPY \--from=0 /build/export /usr/share/nginx/html  
COPY docker /  
  
EXPOSE 443  
CMD ["sh", "/start.sh"]

