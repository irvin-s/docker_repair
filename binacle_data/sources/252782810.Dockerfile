FROM node:4  
RUN apt-get update  
RUN apt-get install -y graphicsmagick  
  
WORKDIR /opt/app  
  
COPY ./package.json /opt/app/package.json  
RUN npm install  
  
COPY . /opt/app/  
  
EXPOSE 3000  
ENV PORT=3000  
CMD ["node", "index.js"]  

