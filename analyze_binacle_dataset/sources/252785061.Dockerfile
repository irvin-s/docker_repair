FROM alpine:3.4  
RUN \  
mkdir -p /aws && \  
apk -Uuv add bash groff less python py-pip && \  
pip install awscli && \  
apk --purge -v del py-pip && \  
rm /var/cache/apk/*  
  
WORKDIR /aws  
ENTRYPOINT ["aws"]  
ENV AWS_DEFAULT_REGION "eu-central-1"  

