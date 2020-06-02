FROM python:3.6-slim  
MAINTAINER simon@simonluijk.com  
COPY ./ /usr/src/aws-register  
RUN cd /usr/src/aws-register && python setup.py install  
ENTRYPOINT ["aws-register"]  

