FROM python:3.4
ENV PYTHONUNBUFFERED 1
RUN apt-get update -qq && apt-get install -y sqlite3
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
