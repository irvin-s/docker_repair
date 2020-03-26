FROM anigeo/awscli  
MAINTAINER Bo Stendal Sorensen <bo@gusto.com>  
  
RUN apk -Uuv add curl jq && rm /var/cache/apk/*  
  
ADD fetcher.sh /  
  
WORKDIR /  
ENTRYPOINT ["/bin/sh", "fetcher.sh"]  

