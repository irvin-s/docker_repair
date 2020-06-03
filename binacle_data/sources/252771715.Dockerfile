FROM node:9.7-alpine  
  
RUN npm install blink-diff  
  
ADD . .  
  
ENTRYPOINT ["./entrypoint.sh"]  

