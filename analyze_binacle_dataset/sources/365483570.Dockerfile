FROM python:3.5
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
RUN apt-get update
RUN apt-get install -y python-dev libldap2-dev libsasl2-dev libssl-dev
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
