FROM alpine:3.4  
RUN mkdir -p /usr/local/bin/ && \  
mkdir -p /docker  
  
RUN apk update && \  
apk add \  
bash \  
curl \  
tar \  
'jq' \  
'python<3.0' \  
'py-pip<8.2.0' \  
&& \  
rm -rf /var/cache/apk/*  
  
RUN pip install awscli  
  
COPY ecr-login.sh /usr/local/bin/ecr-login.sh  
  
ENV AWS_DEFAULT_REGION "us-east-1"  
ENTRYPOINT ["sh", "-c"]  
CMD ["/usr/local/bin/ecr-login.sh"]

