FROM node:5-onbuild  
MAINTAINER Alexey Melnikov <a.melnikov@clickberry.com>  
  
# prepare env vars and run nodejs  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh"]  

