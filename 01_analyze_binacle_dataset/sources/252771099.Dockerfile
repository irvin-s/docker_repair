FROM alpine:edge  
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>  
  
RUN apk add --update bash g++ gcc git libc-dev libffi-dev \  
linux-headers make libressl libressl-dev py-setuptools \  
python python-dev python3 python3-dev swig krb5 krb5-libs \  
krb5-dev curl  
RUN easy_install-2.7 pip && easy_install-3.6 pip  
RUN pip install --upgrade pip virtualenv gunicorn setuptools tox  
RUN rm -rf /var/cache/apk/*  
RUN mkdir /apps  
  
WORKDIR /apps  

