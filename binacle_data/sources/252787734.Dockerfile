FROM python:2.7-alpine  
  
MAINTAINER Virgil Chereches <virgil.chereches@gmx.net>  
  
RUN pip install --upgrade pip setuptools  
RUN pip install bigsuds simpleyaml  
  
RUN apk add --update bash && apk add curl && \  
apk add git && rm -rf /var/cache/apk/*  
  
RUN sed -i -e 's/ash/bash/g' /etc/passwd  
  
ADD configure_rancher_lb.py /configure_rancher_lb.py  
  
ENTRYPOINT /configure_rancher_lb.py  

