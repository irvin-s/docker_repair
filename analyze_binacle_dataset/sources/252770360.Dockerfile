FROM docker.io/halotools/python-sdk:ubuntu-16.04_sdk-1.1.4  
MAINTAINER toolbox@cloudpassage.com  
  
ENV HALO_API_HOSTNAME=api.cloudpassage.com  
  
RUN mkdir /app/  
  
COPY ./app/ /app/  
  
CMD /usr/bin/python2.7 /app/application.py  

