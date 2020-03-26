FROM node:7  
RUN mkdir /practice_docker  
ADD . /practice_docker  
WORKDIR /practice_docker  
RUN npm i  
EXPOSE 80  
CMD ["npm", "start"]

