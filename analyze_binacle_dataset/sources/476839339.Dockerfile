FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y dnsutils imagemagick inkscape
RUN pip install django-adminplus
RUN pip install django-extensions 
RUN apt-get install -y postgresql-client-common 
RUN apt-get install -y postgresql-client
