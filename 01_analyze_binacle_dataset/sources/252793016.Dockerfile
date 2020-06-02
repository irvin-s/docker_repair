FROM alpine  
MAINTAINER Danillo Nunes <marcus@danillo.net>  
  
RUN apk add --update \  
duplicity \  
&& \  
  
rm -rf /var/cache/apk/*  
  
VOLUME "/backup"  
WORKDIR "/backup"  
  
CMD ["/bin/sh", "-c"]  

