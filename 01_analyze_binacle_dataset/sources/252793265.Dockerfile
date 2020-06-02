FROM python:3-alpine  
  
VOLUME /downloads  
  
ENTRYPOINT ["coursera-dl", "--path", "/downloads"]  
  
RUN apk update && \  
apk add build-base && \  
apk add libffi-dev && \  
apk add openssl-dev && \  
pip install coursera-dl && \  
apk del build-base && \  
apk del libffi-dev && \  
apk del openssl-dev  

