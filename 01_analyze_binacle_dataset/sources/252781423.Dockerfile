FROM node:10  
RUN mkdir /src && mkdir /out  
  
WORKDIR /src  
ADD . /src  
RUN yarn install  
  
ENTRYPOINT ["node", "/src/index.js", "--out", "/out"]  

