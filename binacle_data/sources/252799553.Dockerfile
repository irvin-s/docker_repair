FROM python:2-onbuild  
EXPOSE 8080  
CMD ["gunicorn", "--config=docker_config.py", "wsgi:app"]  

