FROM alpine:3.3  
MAINTAINER Alex Bordei - Bigstep Inc.  
  
run apk add --update darkhttpd && rm -rf /var/cache/apk/*  
  
ADD index.html /var/www/localhost/htdocs/index.html  
ADD entrypoint.sh /entrypoint.sh  
  
EXPOSE 80  
ENTRYPOINT ["/entrypoint.sh"]  

