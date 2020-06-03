FROM python:2-onbuild  
CMD ["gunicorn", "app:app", "--bind=0.0.0.0:8000", "--log-file=-"]  
  
EXPOSE 8000  

