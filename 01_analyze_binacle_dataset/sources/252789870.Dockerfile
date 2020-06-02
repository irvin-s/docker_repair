FROM node:6.14.1  
WORKDIR /callstats/geoip  
  
COPY ./callstatsGeoIP/package.json .  
RUN npm install --only=production  
  
ADD ./callstatsGeoIP .  
  
EXPOSE 3000 9399  
CMD [ "npm", "start" ]  

