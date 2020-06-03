FROM python:2-onbuild  
MAINTAINER Christoph Russ <christph.rus@gmail.com>  
  
RUN pip install bottle  
  
COPY data/geometry/* /data/geometry/  
  
EXPOSE 9000  
CMD [ "python", "./start_server.py" ]  

