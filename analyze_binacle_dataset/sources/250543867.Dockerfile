FROM python:2.7
ENV PYTHONUNBUFFERED 1

COPY base/prod-entrypoint.sh /startup/
RUN chmod +x /startup/prod-entrypoint.sh

RUN mkdir /code
WORKDIR /code
ADD base/requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt
ADD . /code/