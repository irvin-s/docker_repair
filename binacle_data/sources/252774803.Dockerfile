FROM python:2.7-alpine3.7  
  
RUN apk add --no-cache --virtual .build-deps \  
gcc \  
musl-dev \  
&& apk add --no-cache librdkafka-dev \  
&& pip install --no-cache-dir confluent-kafka \  
&& apk del .build-deps  
  
CMD ["/bin/sh"]  

