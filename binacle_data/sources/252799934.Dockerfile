FROM alpine:3.7  
LABEL maintainer "DI GREGORIO Nicolas <ndigregorio@ndg-consulting.tech>"  
  
### Environment variables  
ENV LANG='en_US.UTF-8' \  
LANGUAGE='en_US.UTF-8' \  
TERM='xterm'  
### Install Application  
RUN apk --no-cache upgrade && \  
apk add --no-cache --virtual=run-deps \  
certbot \  
bash \  
&& \  
rm -rf /tmp/* \  
/var/cache/apk/* \  
/var/tmp/*  
  
### Volume  
VOLUME ["/etc/letsencrypt"]  
  
### Expose ports  
EXPOSE 80  
EXPOSE 443  
### Running User: not used, managed by docker-entrypoint.sh  
USER root  
  
### Start certbot  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["certbot"]  

