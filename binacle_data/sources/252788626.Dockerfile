FROM node  
  
MAINTAINER Christian Haug  
  
RUN mkdir -p /src  
WORKDIR src  
  
COPY package.json /src  
RUN npm install  
  
COPY . /src  
  
EXPOSE 5000  
CMD ["npm", "run", "start_prod"]  

