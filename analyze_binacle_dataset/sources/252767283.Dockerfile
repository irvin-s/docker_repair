FROM google/nodejs-runtime  
MAINTAINER Alexey Melnikov <alexey.ernest@gmail.com>  
  
# gulp  
RUN npm install -g gulp  
RUN gulp  
  
# prepare env vars and run nodejs  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh"]

