FROM node:8.6.0  
MAINTAINER Ferran Vila ferran.vila.conesa@gmail.com  
  
WORKDIR /home/app  
EXPOSE 3000  
# copy the app, install app dependencies and compile it  
COPY . /home/app  
RUN npm install --loglevel warn  
  
CMD ["node", "."]

