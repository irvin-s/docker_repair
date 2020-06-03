FROM python:3.6.1-slim  
  
MAINTAINER Chris Baptista  
  
RUN pip install cherrypy  
  
CMD ["python3", "app.py"]  

