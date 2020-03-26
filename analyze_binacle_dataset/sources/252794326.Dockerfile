FROM library/python:2-alpine  
  
MAINTAINER Bastian Widmer <b.widmer@dasrecht.net>  
  
  
RUN pip install yamllint  
ADD yamllint.yaml /etc/  
WORKDIR /data  
  
ENTRYPOINT exec yamllint -c /etc/yamllint.yaml **/*.yaml  

