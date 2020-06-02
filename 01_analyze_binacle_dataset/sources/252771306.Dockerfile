FROM alpine  
MAINTAINER Zenobius Jiricek <airtonix@gmail.com>  
ENV CERT_ROOT=/concourse-certs  
  
RUN apk add --update \  
openssh-client && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /concourse-certs/web && \  
mkdir /concourse-certs/worker  
  
ADD ./entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

