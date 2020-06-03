#
# Dockerfile for deploying the COMRADES CREES Services (COMRADES Crisis Event Extraction Services).
#
#FROM python:2.7.14-alpine3.6
FROM ubuntu:16.04
LABEL maintainer="Grégoire Burel <evhart@users.noreply.github.com>"

RUN apt-get update && apt-get install -y python-pip python-dev && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir tensorflow==0.12.1 flask flask-restplus numpy enum34

COPY data_helpers.py /home/data_helpers.py
COPY text_cnn.py /home/text_cnn.py
COPY crees_server.py	/home/crees_server.py
COPY models/ /home/models/

WORKDIR /home

CMD ["python","crees_server.py"]