FROM python:2.7  
MAINTAINER "Jared Blouse"  
ENV VERSION 1  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
ADD requirements.pip /code/  
RUN pip install -r requirements.pip  
ADD . /code/  
ENV DJANGO_SETTINGS_MODULE=pain_manager.settings  
  
CMD ["/code/start_app.sh"]  

