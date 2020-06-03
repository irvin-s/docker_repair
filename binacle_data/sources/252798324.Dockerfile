FROM node:7.6  
MAINTAINER Matías Lescano <matias@democraciaenred.org>  
  
WORKDIR /usr/src  
  
COPY ["package.json", "/usr/src/"]  
  
ENV NODE_ENV=production  
  
RUN npm install --quiet  
  
COPY [".", "/usr/src/"]  
  
ENV MONGO_URL=mongodb://mongo/billtracker  
  
RUN npm run build -- --minify  
  
EXPOSE 3000  
CMD ["npm", "start"]  

