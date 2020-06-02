FROM python:2-alpine  
  
RUN apk add \--no-cache \--virtual build-deps g++ gcc libxslt-dev \  
&& pip install lxml \  
&& apk del build-deps \  
&& pip install translate-toolkit \  
&& apk add \--no-cache libxslt  

