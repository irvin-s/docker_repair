FROM tiangolo/uwsgi-nginx-flask:flask-python3.5  
RUN pip3 install --no-cache-dir requests  
  
COPY ./app /app

