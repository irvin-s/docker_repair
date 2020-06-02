FROM bytesized/base  
MAINTAINER maran@bytesized-hosting.com  
  
RUN apk --no-cache add znc znc-modperl znc-modtcl znc-extra ca-certificates  
  
COPY /static /  
VOLUME /config  
  
EXPOSE 6868  

