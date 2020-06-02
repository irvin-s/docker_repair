FROM quay.io/dukegcb/python-web-base:2.7-onbuild  
MAINTAINER dan.leehr@duke.edu  
  
EXPOSE 8000  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]  

