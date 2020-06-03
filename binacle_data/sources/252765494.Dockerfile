FROM python:3.5.3-alpine  
  
  
RUN apk --no-cache add --virtual .build-deps \  
build-base \  
curl-dev && \  
pip install celery celery[sqs] redis kazoo flower==0.9.1 && \  
apk del .build-deps  
  
EXPOSE 5555/tcp  
CMD ["celery", "flower", "--address=0.0.0.0", "--port=5555"]  

