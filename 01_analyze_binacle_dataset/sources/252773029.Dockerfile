FROM python:alpine3.6  
MAINTAINER David Sarrio <dsarrio@betomorrow.com>  
  
RUN apk --no-cache --update-cache add \  
bash  
  
ADD ymlerger.py /dist/ymlerger.py  
  
ENTRYPOINT ["/usr/local/bin/python", "/dist/ymlerger.py"]  

