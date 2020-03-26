#  
# A Docker container which redirects all received web requests.  
#  
# vi: set ts=4 ff=unix :  
#  
FROM alpine:latest  
  
RUN \  
apk update \  
&& apk add \  
openssl \  
nginx \  
gettext  
  
COPY overlay/ /  
  
WORKDIR /scripts  
EXPOSE 80  
ENV \  
REDIRECT_TARGET=http://www.example.com/ \  
REDIRECT_HTTP_CODE=301  
ENTRYPOINT ["/scripts/bootstrap.sh"]  
  

