FROM python:2.7-alpine  
MAINTAINER Hauke Loeffler <mail@hauke-loeffler.de>  
  
ADD . /src  
RUN cd /src && python setup.py install  
  
EXPOSE 5000  
ENTRYPOINT cd /src && python run.py

