FROM alpine:3.2  
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>  
  
RUN apk add --update \  
python \  
python-dev \  
py-pip \  
g++ && \  
pip install cookiecutter && \  
apk del g++ py-pip python-dev && \  
rm -rf /var/cache/apk/*  
  
  
ENTRYPOINT [ "cookiecutter" ]  

