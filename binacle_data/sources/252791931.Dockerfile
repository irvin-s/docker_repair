From alpine:3.5  
MAINTAINER Jimin Huang "huangjimin@whu.edu.cn"  
ENV PACKAGES="\  
dumb-init \  
bash \  
git \  
python \  
python-dev \  
openssh \  
py-mysqldb \  
"  
RUN apk update && \  
apk add --update --no-cache $PACKAGES && \  
python -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip install --upgrade pip setuptools nose && \  
rm -r /root/.cache  
  
VOLUME ["/code"]  
WORKDIR code  
  
ENTRYPOINT dumb-init  

