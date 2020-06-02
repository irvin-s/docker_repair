FROM ayaz/dockerpythonapp:latest  
LABEL maintainer="Ayaz"  
  
COPY ./app.py /usr/src/app  
COPY ./gunicorn.conf.py /usr/src/app  
  
EXPOSE 6000  
ENTRYPOINT ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]  
  

