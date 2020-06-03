FROM python:3-alpine  
MAINTAINER Samiur Rahman <samiur@canopyiq.com>  
  
RUN pip3 install --no-cache-dir twine==1.8.1  
  
ENTRYPOINT ["twine"]  

