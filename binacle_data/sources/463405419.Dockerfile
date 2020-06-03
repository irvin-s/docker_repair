FROM python:3-alpine
ENV PYTHONUNBUFFERED 1
RUN pip install pipenv
RUN mkdir /code
WORKDIR /code
ADD Pipfile /code/
RUN pipenv install
ADD . /code/
