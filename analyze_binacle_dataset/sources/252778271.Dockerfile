FROM alpine:3.5  
MAINTAINER community@apstra.com  
  
RUN mkdir /source \  
&& mkdir /scripts  
  
WORKDIR /source  
  
## Copy project inside the container  
ADD setup.py setup.py  
ADD requirements.txt requirements.txt  
ADD pylib pylib  
  
## Install dependancies  
RUN apk update \  
&& apk upgrade \  
&& apk add build-base gcc g++ make python-dev py-pip curl wget \  
&& update-ca-certificates \  
&& pip install -r requirements.txt \  
&& apk del -r --purge gcc make g++ \  
&& python setup.py install \  
&& rm -rf /source/* \  
&& rm -rf /var/cache/apk/*  
  
WORKDIR /scripts  
  
VOLUME ["$PWD:/scripts"]  
  
CMD sh  

