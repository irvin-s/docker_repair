FROM alpine:latest  
MAINTAINER "Aleksandr Derbenev <ya.alex-ac@yandex.com"  
EXPOSE 80  
RUN apk --update add lighttpd && rm -rf /var/cache/apk/* && \  
mkdir -p /etc/lighttpd/lighttpd.conf.d/ && \  
touch /etc/lighttpd/lighttpd.conf.d/empty && \  
echo 'include_shell "cat /etc/lighttpd/lighttpd.conf.d/*"' >> \  
/etc/lighttpd/lighttpd.conf  
CMD [ "/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]  
  

