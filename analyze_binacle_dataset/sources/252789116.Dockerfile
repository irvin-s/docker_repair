FROM nginx:stable  
  
MAINTAINER Dmitry Shmelev, dmitry.shmelev@jetbrains.com  
  
ENV RESOLVER_PARAMS="valid=10s"  
ENV RESOLVER_FILEPATH /etc/nginx/resolver.conf  
  
COPY ./entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

