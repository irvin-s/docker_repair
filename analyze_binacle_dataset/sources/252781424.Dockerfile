FROM node:10  
RUN mkdir /src  
  
WORKDIR /src  
ADD . /src  
RUN yarn install  
  
ENV HOST 0.0.0.0  
EXPOSE 3000  
WORKDIR /src  
  
CMD yarn start  

