FROM alpine:latest  
  
RUN buildDeps=" \  
python-dev \  
py2-pip \  
linux-headers \  
make \  
g++ \  
"; \  
set -xe \  
&& apk add --update python \  
&& apk add $buildDeps \  
&& pip install pycrypto \  
&& apk del $buildDeps \  
&& rm -rf /var/cache/apk/*  
  
COPY swjsq.py /  
  
ENTRYPOINT ["python", "-u", "/swjsq.py"]  

