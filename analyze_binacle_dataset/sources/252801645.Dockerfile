FROM python:2.7  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
  
ADD pip_requirements.txt /code/  
RUN pip install -r pip_requirements.txt  
  
ADD . /code/

