FROM node  
  
MAINTAINER chris@cbeer.info  
  
RUN npm install -g coffee-script edsu/anon  
  
ENTRYPOINT ["anon"]  
  
ADD env-based-config.js /config/config.js  
  
CMD ["--config /config/config"]  

