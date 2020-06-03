FROM python:3.5
MAINTAINER olpi

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -qq -y build-essential libffi-dev python3-dev openssl

RUN mkdir -p /app/src

# We copy the requirements.txt file first to avoid cache invalidations
COPY requirements.txt /app/src

WORKDIR /app/src

RUN python3 -m pip install pip --upgrade
RUN python3 -m pip install -r requirements.txt

COPY . /app/src

# set environment variables
RUN python3 set_env.py
#RUN environments/local.env

EXPOSE 5000
CMD ["python3", "api.py"]
