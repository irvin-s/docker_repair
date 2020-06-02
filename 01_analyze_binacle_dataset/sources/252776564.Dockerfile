FROM node  
MAINTAINER Pablo Castro <castrinho8@gmail.com>  
  
RUN apt-get -y update && apt-get install -y nodejs && apt-get install -y npm  
RUN mkdir -p /usr/tickets-web  
COPY . /usr/tickets-web  
  
WORKDIR /usr/tickets-web  
RUN npm install  
  
EXPOSE 3000  
CMD npm run start  

