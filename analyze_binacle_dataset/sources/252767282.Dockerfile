FROM node:5-onbuild  
MAINTAINER Alex Melnikov <alexey.ernest@yandex.ru>  
  
# build  
RUN npm run build  
  
# prepare env vars and run nodejs  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh"]  
  
EXPOSE 8080  

