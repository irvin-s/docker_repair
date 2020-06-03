FROM docker:latest  
  
RUN \  
mkdir -p /aws && \  
apk -Uuv add --no-cache groff less python py-pip docker openrc && \  
pip install awscli && \  
apk --purge -v del py-pip && \  
rm /var/cache/apk/*  
  

