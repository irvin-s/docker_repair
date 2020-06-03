FROM node:5-onbuild  
MAINTAINER Alex Melnikov <alexey.ernest@yandex.ru>  
  
# gulp  
RUN npm install -g gulp  
RUN gulp  
  
# prepare env vars and run nodejs  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh"]  
  
EXPOSE 8080

