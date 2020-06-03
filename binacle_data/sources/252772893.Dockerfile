FROM node:7  
MAINTAINER Berry Goudswaard <info@berrygoudswaard.nl>  
  
RUN npm install pm2 -g  
  
EXPOSE 3000  
CMD ["pm2" "--no-daemon" "--env", "production" "start"]  

