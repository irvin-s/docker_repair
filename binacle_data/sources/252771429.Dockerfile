FROM ajoergensen/baseimage-alpine  
  
COPY root/ /  
  
RUN \  
apk -U upgrade && \  
apk add sphinx && \  
mv /etc/sphinx/sphinx.conf.dist /etc/sphinx/sphinx.conf && \  
rm -rf /var/cache/apk/*  
  
RUN \  
chmod -v +x /etc/services.d/*/run  
  
VOLUME [ "/var/lib/sphinxsearch" ]  
  
EXPOSE 9306 9312  

