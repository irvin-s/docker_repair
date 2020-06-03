FROM node:7  
RUN mkdir -p /usr/app  
ADD . /usr/app  
WORKDIR /usr/app/  
  
RUN apt-get update  
RUN npm install  
RUN npm install serve  
RUN rm -rf build  
RUN npm run build  
EXPOSE 5000  
CMD ["cd", "/usr/app"]  
CMD ["node", "./node_modules/serve/bin/serve.js", "build"]  

