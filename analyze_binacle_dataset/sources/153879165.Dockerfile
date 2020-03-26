FROM python:2.7
RUN apt-get update
RUN apt-get install -y libmemcached-dev
ENV PYTHONUNBUFFERED 1
ADD . /code
WORKDIR /code
EXPOSE 8080
RUN pip install https://www.djangoproject.com/download/1.7c3/tarball/ -e .
