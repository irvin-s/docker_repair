FROM python:2.7
ENV PYTHONUNBUFFERED 1
ENV LK_ENV development_docker
ENV TERM linux
RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN pip install -r requirements.txt
