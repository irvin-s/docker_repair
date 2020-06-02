FROM python:3  
MAINTAINER Haiwei Liu <carllhw@gmail.com>  
  
COPY requirements.txt /  
RUN pip install -r requirements.txt  
  
CMD ["pg_activity", "--help"]  

