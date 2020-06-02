FROM alpine:latest  
  
RUN \  
mkdir -p /aws && \  
apk -Uuv add jq groff less python py-pip && \  
pip install awscli && \  
apk --purge -v del py-pip && \  
rm /var/cache/apk/*  
  
COPY sync.sh /sync.sh  
  
CMD /bin/sh /sync.sh  

