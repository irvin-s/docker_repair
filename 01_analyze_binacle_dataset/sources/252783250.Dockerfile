FROM node  
  
RUN mkdir /src  
  
RUN npm i nodemon -gq  
  
WORKDIR /src  
ADD . /src  
RUN npm i -q  
  
EXPOSE 3000  
CMD npm start

