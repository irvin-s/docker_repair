# vim:set ft=dockerfile:  
FROM mhart/alpine-node:base  
  
MAINTAINER dre@designet.com  
  
RUN apk --update-cache add bash postgresql-client  
  
COPY docker-entrypoint.sh /  
COPY retry_func.sh /  
COPY src/ /src  
  
WORKDIR /src  
ENTRYPOINT ["/docker-entrypoint.sh"]  

