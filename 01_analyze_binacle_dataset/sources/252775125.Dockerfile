FROM node:4.4.7  
COPY . /src  
WORKDIR /src  
  
RUN npm install  
  
EXPOSE 80  
ENV PORT=80  
CMD node ./bin/www  

