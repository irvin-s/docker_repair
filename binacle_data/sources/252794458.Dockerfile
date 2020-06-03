FROM python:2-onbuild  
MAINTAINER Li-Te Chen <datacoda@gmail.com>  
  
ENTRYPOINT ["python", "/usr/src/app/server.py"]  
CMD ["80"]  

