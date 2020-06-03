FROM alpine  
MAINTAINER "José Roberto Assis <assisjrt@gmail.com>"  
EXPOSE 80  
RUN apk --update add lighttpd && rm -rf /var/cache/apk/*  
ADD lighttpd.conf /etc/lighttpd/  
  
CMD [ "/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]  

