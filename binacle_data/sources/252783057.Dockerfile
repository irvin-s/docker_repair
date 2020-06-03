FROM python:3.6.5  
COPY requirements.txt /tmp/  
  
RUN pip install -U pip  
RUN pip install uwsgi  
RUN pip install -r /tmp/requirements.txt  
  
COPY ./app /app  
ENV HOME /app  
WORKDIR /app  
  
EXPOSE 80  
ENTRYPOINT ["uwsgi", "--http", "0.0.0.0:80", "--module", "app:app"]  

