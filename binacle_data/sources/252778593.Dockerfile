FROM node:alpine  
  
WORKDIR /src  
ADD . /src  
RUN npm i  
  
EXPOSE 80  
CMD ["node", "index"]

