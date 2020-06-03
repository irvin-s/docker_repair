FROM node:6.10.3  
RUN mkdir /served  
RUN echo "hello world!" > /served/file  
  
ENV FILE_PATH /served/file  
ENV PORT 8080  
EXPOSE 8080  
ADD . ./app  
WORKDIR ./app  
  
CMD npm start  

