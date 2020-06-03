FROM node:8-alpine  
  
MAINTAINER Hideyuki TAKEUCHI <chimerast@gmail.com>  
  
WORKDIR /app  
  
ADD . .  
  
RUN ["npm", "install"]  
  
ENV PORT 80  
EXPOSE 80  
CMD ["node", "bot.js"]  

