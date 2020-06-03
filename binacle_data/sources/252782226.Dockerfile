FROM tiangolo/uwsgi-nginx-flask:python3.6-alpine3.7  
COPY . /app  
RUN pip install -r /app/requirements.txt  

