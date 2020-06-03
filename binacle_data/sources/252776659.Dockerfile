FROM tiangolo/uwsgi-nginx-flask:flask-python3.5-index  
  
COPY ./requirements.txt /requirements.txt  
WORKDIR /  
RUN pip install -r requirements.txt  
WORKDIR /app  
ENV PYTHONPATH $PYTHONPATH:/  
  
COPY ./app /app  

