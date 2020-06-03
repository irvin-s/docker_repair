FROM python:3  
ENV PYTHONUNBUFFERED 1  
#ENV http_proxy http://169.154.0.13:3128/  
#ENV https_proxy https://169.154.0.13:3128/  
RUN mkdir /code  
RUN apt-get update && apt-get install gettext cron -y  
WORKDIR /code  
ADD requirements.txt /code/  
RUN pip install -r requirements.txt  
ADD . /code/  

