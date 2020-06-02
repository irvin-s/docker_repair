FROM node:5-onbuild  
MAINTAINER Alexey Melnikov <alexey.ernest@gmail.com>  
  
# prepare env vars and run nodejs  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh"]  
  
EXPOSE 8080  

