FROM python:2.7.14  
WORKDIR /opt/bitwrap  
COPY requirements.txt requirements.txt  
RUN pip install -r requirements.txt  
COPY . .  
RUN pip install .  
  
ENV GUNICORN_WORKERS 5  
EXPOSE 8080  
ENTRYPOINT ["./entry.sh"]  

