FROM alpine:3.2  
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>  
  
RUN apk add --update openssl nginx bash  
RUN mkdir -p /webapps/sites /webapps/conf /webapps/logs \  
/webapps/cache /webapps/scripts /webapps/ssl \  
&& chown -R nginx:nginx /webapps \  
&& chown -R nginx:nginx /var/lib/nginx  
  
COPY assets/scripts /webapps/scripts  
COPY assets/conf /webapps/conf/  
RUN chmod +x /webapps/scripts/* \  
&& ln -s /webapps/scripts/domain.sh /usr/bin/domain \  
&& ln -s /webapps/scripts/path.sh /usr/bin/path  
  
RUN rm -rf /var/cache/apk/*  
  
CMD ["/usr/sbin/nginx","-c","/webapps/conf/nginx.conf"]  
  
EXPOSE 80 443  
ENV SHELL /bin/bash  

