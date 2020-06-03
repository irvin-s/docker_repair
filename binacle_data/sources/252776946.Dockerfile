FROM alpine  
MAINTAINER Cecile Tonglet <cecile.tonglet@gmail.com>  
  
RUN apk update  
RUN apk add ca-certificates py-setuptools  
  
RUN easy_install-2.7 docker-py python-dateutil  
  
ADD /run.py /app/run.py  
  
ENTRYPOINT ["/app/run.py"]  

