FROM python:2.7  
MAINTAINER Jennifer Liao <cutejaneii@hotmail.com>  
  
RUN pip install flask  
RUN apt-get update  
RUN apt-get -y install python-pip  
RUN pip install kafka-python  
RUN pip install pystrich  
  
RUN mkdir /app  
  
COPY ./app /app  
  
WORKDIR /app  
  
CMD ["python", "main.py"]  

