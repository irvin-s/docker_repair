FROM node  
RUN mkdir /devdocker  
ADD . /devdocker  
WORKDIR /devdocker  
RUN npm i  
EXPOSE 80  
CMD ["npm", "start"]

