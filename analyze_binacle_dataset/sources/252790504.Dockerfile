FROM cargonauts/python:2.7  
RUN pip install flask redis  
  
ADD *.py /srv/  
EXPOSE 80  

