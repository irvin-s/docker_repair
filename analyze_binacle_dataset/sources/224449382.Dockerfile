FROM python:3.4

COPY . /app/streamer/
WORKDIR /app/streamer/

RUN pip install -r /app/streamer/requirements.txt
