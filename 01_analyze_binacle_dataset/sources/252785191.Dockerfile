FROM python:2.7  
ADD elk_export.py setup.py requirements.txt /var/src/elk_export/  
WORKDIR /var/src/elk_export  
  
RUN python setup.py install  
  
ENTRYPOINT ["elk-export"]

