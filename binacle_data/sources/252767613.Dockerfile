FROM alpine:3.4  
MAINTAINER Anton Kasperovich <anton.kaspiarovich@accenture.com>  
  
RUN apk add --update python python-dev py-pip \  
gcc musl-dev linux-headers \  
augeas-dev openssl-dev libffi-dev ca-certificates dialog \  
&& rm -rf /var/cache/apk/*  
  
ENV CERTBOT_VERSION 0.8.1  
RUN pip install -U certbot==$CERTBOT_VERSION  
  
EXPOSE 80 443  
VOLUME /etc/letsencrypt/  
  
ENTRYPOINT ["certbot"]  

