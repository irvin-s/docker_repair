FROM python:2.7
ENV PYTHONBUFFERRED 1
RUN pip install --upgrade pip

RUN mkdir /demo

WORKDIR /demo/
ADD demo/requirements.txt /demo/requirements.txt
RUN pip install -r requirements.txt

ADD demo /demo/

