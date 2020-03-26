FROM python:3.4  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
ADD requirements.txt /code/  
RUN pip install -r requirements.txt  
ADD . /code/  
#CMD uwsgi --socket :8000 --module home_automation.wsgi  
#CMD uwsgi --http :8000 --module home_automation.wsgi  

