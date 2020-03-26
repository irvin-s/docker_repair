FROM alpine:3.7  
LABEL maintainer="marco.miglierina@contentwise.tv"  
RUN apk --update add \  
python \  
py-pip \  
openssl \  
ca-certificates \  
build-base \  
bash \  
git \  
openssh \  
rsync && \  
apk --update add --virtual build-dependencies \  
python-dev \  
libffi-dev \  
openssl-dev && \  
pip install --upgrade pip cffi && \  
pip install ansible==2.4.1.0 awscli==1.14.9 boto boto3 && \  
apk del build-dependencies && \  
rm -rf /var/cache/apk/*  
CMD ["bash"]

