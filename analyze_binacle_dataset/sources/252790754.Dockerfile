FROM alpine  
  
RUN apk --update --no-cache add varnish inotify-tools && \  
echo "Success."  
  
COPY ./files/default.vcl /etc/varnish/default.vcl  
COPY ./files/varnish.params /etc/varnish/varnish.params  
COPY ./files/start.sh /start.sh  
RUN chmod +x /start.sh  
  
ENV VARNISH_MEMORY 64M  
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600  
EXPOSE 80  
CMD ["/start.sh"]  

