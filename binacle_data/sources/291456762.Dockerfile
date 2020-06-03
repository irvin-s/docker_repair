FROM python:2.7.16-slim
MAINTAINER Kevin Lin <developer@kevinlin.info>

ARG sha
ARG database_host
ARG database_port
ARG database_name
ARG database_user
ARG database_password

RUN apt-get update && apt-get install -y wget unzip python-dev default-libmysqlclient-dev gcc build-essential

RUN wget -O orion-server.zip https://github.com/LINKIWI/orion-server/archive/$sha.zip
RUN unzip orion-server.zip
WORKDIR "orion-server-$sha"

RUN pip install -r requirements.txt
RUN pip install gunicorn

ENV DATABASE_HOST $database_host
ENV DATABASE_PORT $database_port
ENV DATABASE_PORT $database_port
ENV DATABASE_NAME $database_name
ENV DATABASE_USER $database_user
ENV DATABASE_PASSWORD $database_password
ENV PYTHONPATH "/orion-server-$sha"

EXPOSE 80

CMD make init-db && gunicorn --bind 0.0.0.0:80 -w 4 orion.server:app
