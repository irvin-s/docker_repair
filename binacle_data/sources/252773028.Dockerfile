FROM python:alpine3.6  
MAINTAINER David Sarrio <dsarrio@betomorrow.com>  
  
RUN apk --no-cache --update-cache add \  
bash  
  
ADD tfmerger.py /dist/tfmerger.py  
  
ENTRYPOINT ["/usr/local/bin/python", "/dist/tfmerger.py"]  

