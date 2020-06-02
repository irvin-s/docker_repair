FROM python:3.6.2-alpine3.6  
ENV AWS_CLI_VERSION 1.11.163  
RUN pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /data  

