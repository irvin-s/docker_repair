FROM alpine:latest  
MAINTAINER Simon Weald <simon@simonweald.com>  
  
ENV DOCKERISED=true  
  
ENV PACKAGES="\  
build-base \  
ca-certificates \  
py-openssl \  
python3 \  
python3-dev \  
"  
ENV PIP_PACKAGES="\  
docopt \  
twisted \  
requests \  
"  
ENV PURGE_PACKAGES="\  
build-base \  
python3-dev"  
RUN \  
apk add --no-cache $PACKAGES && \  
python3 -m ensurepip && \  
pip3 install --upgrade pip && \  
pip3 install $PIP_PACKAGES && \  
apk del --purge $PURGE_PACKAGES  
  
COPY dns_update.py /usr/local/bin/  
  
ENTRYPOINT [ "python3", "/usr/local/bin/dns_update.py" ]  
  
CMD [ "-h" ]  

