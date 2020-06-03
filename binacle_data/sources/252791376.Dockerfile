FROM python:alpine  
RUN apk add --no-cache --virtual .build-deps \  
gcc \  
libc-dev  
RUN pip install bottle  
RUN pip install requests  
  

