FROM python:3-onbuild  
EXPOSE 5000  
CMD ["gunicorn", "fountainheadstatus:app", "--bind=0:5000"]  

