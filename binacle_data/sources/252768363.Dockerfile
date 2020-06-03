FROM python:3.6-slim  
MAINTAINER Adrian Lopez <adrianlzt@gmail.com>  
  
COPY requirements.txt /requirements.txt  
COPY wsgi.py /wsgi.py  
RUN pip install -r requirements.txt  
  
EXPOSE 8080  
CMD ["gunicorn", "wsgi", "--bind=0.0.0.0:8080", "--access-logfile=-"]  

