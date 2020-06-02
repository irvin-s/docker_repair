FROM alpine  
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz> (@casualjim)  
  
ADD su-exec /bin  
ADD dumb-init /bin  
  
RUN set -x &&\  
apk add --no-cache mailcap ca-certificates &&\  
update-ca-certificates &&\  
rm -rf /var/cache/apk/*  
  

