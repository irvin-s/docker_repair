FROM tiangolo/uwsgi-nginx-flask:flask-index  
  
RUN apt-get update  
  
RUN apt-get -y install python-pip  
  
RUN pip install kafka-python  
  
COPY ./app /app  

