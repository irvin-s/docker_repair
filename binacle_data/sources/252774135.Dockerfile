FROM alpine  
  
RUN apk update && apk add apache2 --no-cache && \  
apk add openrc --no-cache && \  
rm -rf /var/cache/apk/* && \  
mkdir /run/apache2/  
  
EXPOSE 80  
ENV HTDOCS=/var/www/localhost/htdocs  
  
VOLUME $(HTDOCS)  
  
RUN echo " <p> It is working </p>" > $HTDOCS/index.html  
  
WORKDIR $HTDOCS  
  
ENTRYPOINT ["httpd", "-D", "FOREGROUND"]  
  
#CMD /bin/sh

