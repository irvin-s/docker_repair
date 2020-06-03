FROM sickp/alpine-nginx  
  
ADD *.conf /etc/nginx/  
ADD *.htpasswd /etc/nginx/  
ADD conf.d/* /etc/nginx/conf.d/  
ADD startup.sh /startup.sh  
  
ADD 500.html /usr/share/nginx/errors/500.html  
  
RUN mkdir /var/datapackages && chown -R nginx:nginx /var/datapackages  
VOLUME ["/var/datapackages"]  
VOLUME ["/var/_fonts"]  
  
EXPOSE 80  
# We need to wait for the internal dns resolving to kick in  
CMD /startup.sh  

