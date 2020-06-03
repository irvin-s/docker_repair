FROM python:3.6
MAINTAINER Aaron AaronBatilo@gmail.com

ADD . /code
WORKDIR /code

COPY ./Pipfile .
COPY ./Pipfile.lock .
RUN pip install pipenv
RUN pipenv install --system --deploy

EXPOSE 8000

CMD ["python", "examples/cars/main.py"]
