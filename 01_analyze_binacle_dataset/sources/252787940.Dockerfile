FROM nginx:1.10-alpine  
  
MAINTAINER Marc Lopez <marc5.12@outlook.com>  
  
ENV CODE_DIR /home/app/app  
WORKDIR $CODE_DIR  
  
ADD docker-entrypoint.sh /docker-entrypoint.sh  
  
RUN apk --update add bash \  
&& rm -rf /var/cache/apk/* \  
&& chmod +x /docker-entrypoint.sh  
  
ADD application.conf /etc/nginx/conf.d/default.conf  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

