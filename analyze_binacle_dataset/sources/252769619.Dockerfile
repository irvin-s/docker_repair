FROM mhart/alpine-node:6.1.0  
MAINTAINER Takuya Arita <takuya.arita@gmail.com>  
  
ENV PORT 8080  
RUN mkdir /botkit && \  
cd /botkit && \  
npm install botkit  
COPY bot.js /botkit/  
  
EXPOSE ${PORT}  
  
CMD cd /botkit && node bot.js  

