FROM python:3.6-alpine  
  
RUN apk upgrade && \  
apk add --no-cache --virtual build-dependencies linux-headers make gcc \  
g++ ca-certificates zlib-dev jpeg-dev tiff-dev freetype-dev lcms2-dev \  
libwebp-dev tcl-dev tk-dev libxml2-dev libxslt-dev git && \  
rm -rf /var/cache/apk/*  
  
ADD requirements.txt /var/requirements.txt  
  
RUN pip install -r /var/requirements.txt  

