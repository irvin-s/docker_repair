FROM python:3.6-alpine  
MAINTAINER Ashic Mahtab (ashic@live.com)  
  
RUN sed -i -e 's/v3\\.4/edge/g' /etc/apk/repositories && \  
apk --no-cache add alpine-sdk librdkafka-dev && \  
pip install --no-cache-dir confluent-kafka[avro]==0.11.0 && \  
apk del alpine-sdk && \  
rm -rf /root/cache/*  

