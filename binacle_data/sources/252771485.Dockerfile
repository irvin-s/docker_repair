FROM python:2.7  
WORKDIR /usr/src/app  
COPY ./ /usr/src/app  
CMD python server.py  

