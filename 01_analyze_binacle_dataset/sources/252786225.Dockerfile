FROM python:3.6-alpine  
MAINTAINER Darwin Monroy <contact@darwinmonroy.com>  
  
RUN pip3 install uh  
  
EXPOSE 8000  
CMD python3 -m uh.__init__

