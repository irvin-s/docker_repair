FROM alpine:3.7  
LABEL maintainer "Kazuya Hara"  
  
ENV AWSCIL_VERSION=1.14.22  
RUN apk add -v --update python py-pip curl yarn && \  
yarn global add serverless && \  
pip install awscli==${AWSCIL_VERSION} && \  
apk del -v --purge py-pip && \  
rm /var/cache/apk/*  
  
COPY . .  

