# Dockerfile
FROM python:3.6

ENV PYTHONUNBUFFERED 1

RUN mkdir /src
WORKDIR /src
COPY requirements.txt /src

RUN pip install -r requirements.txt

COPY . /src

RUN mkdir -p /var/log/django/codexpose/
RUN touch /var/log/django/codexpose/codexpose.log

CMD ["/src/entrypoint.sh"]
