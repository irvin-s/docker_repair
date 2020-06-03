FROM resin/raspberrypi3-python:2-slim

COPY requirements-armv7l.txt ./

RUN [ "cross-build-start" ]
RUN apt-get update
RUN apt-get install -y build-essential python-dev
RUN pip install --no-cache-dir -r requirements-armv7l.txt
RUN [ "cross-build-end" ]  
