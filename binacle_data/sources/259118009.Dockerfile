
FROM python:3.5 

MAINTAINER 彭河森 hesen.peng@gmail.com

ADD . /code

WORKDIR /code

RUN pip install -r requirements.txt

CMD python hello.py