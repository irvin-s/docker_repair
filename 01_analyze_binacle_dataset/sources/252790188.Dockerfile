FROM alpine  
  
ENV BUILD_PACKAGES bash curl-dev git nodejs  
  
# Update  
RUN apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /dataviz  
  
VOLUME ["/dataviz"]  
  
ADD setup.sh /setup.sh  
  
RUN chmod 755 /setup.sh  
  
EXPOSE 8080  
CMD ["/bin/bash" , "/setup.sh"]  

