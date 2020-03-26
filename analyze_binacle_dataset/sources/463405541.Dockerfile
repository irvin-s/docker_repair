FROM python:3-alpine
ENV PYTHONUNBUFFERED 1
RUN pip install pipenv
RUN mkdir /code
WORKDIR /code
ADD Pipfile /code/
ADD Pipfile.lock /code/
RUN pipenv install --dev --system --deploy
ADD . /code/
