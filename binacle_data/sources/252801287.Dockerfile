# Pull base image.  
FROM rnbwd/node-io  
  
MAINTAINER RnbWd <dwisner6@gmail.com>  
  
ENV path /sinopia  
  
WORKDIR $path  
ADD . $path  
  
RUN npm install --production  
RUN npm cache clean  
  
CMD ["./bin/sinopia"]  
  
EXPOSE 4873  
VOLUME $path/storage  

