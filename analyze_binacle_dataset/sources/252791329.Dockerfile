FROM node:latest  
  
COPY . /src  
RUN npm install -g /src  
  
EXPOSE 9000  
CMD ["shout"]  

