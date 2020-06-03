FROM mhart/alpine-node:4  
RUN apk add --no-cache curl  
  
WORKDIR /src  
ADD . .  
  
HEALTHCHECK \--timeout=3s --retries=2 \  
CMD curl -f http://localhost:3000/ping || exit 1  
  
ENV NODE_ENV production  
  
RUN npm install  
  
EXPOSE 3000  
CMD ["node", "index.js"]  

