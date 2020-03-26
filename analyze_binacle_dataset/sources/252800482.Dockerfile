FROM alpine:3.2  
  
MAINTAINER domeos  
  
RUN apk add -U curl python && \  
curl -sSL https://bootstrap.pypa.io/get-pip.py | python && \  
pip install virtualenv && \  
rm -rf /var/cache/apk/*  
  
CMD ["python"]  
  

