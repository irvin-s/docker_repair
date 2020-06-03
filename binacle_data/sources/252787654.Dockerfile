FROM alpine  
MAINTAINER Anders Brujordet "anders@brujordet.no"  
RUN apk --update add varnish bash coreutils bc  
  
RUN rm -rf /etc/varnish  
  
EXPOSE 6081  
ADD vtcunit /vtcunit  
ADD docker-entrypoint /docker-entrypoint  
CMD ["/docker-entrypoint"]  

