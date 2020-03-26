FROM python:3-onbuild  
MAINTAINER belak@coded.io  
  
RUN pip install psycopg2  
  
ENV PYTHONUNBUFFERED true  

