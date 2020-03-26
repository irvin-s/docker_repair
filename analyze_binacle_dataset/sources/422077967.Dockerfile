FROM python:3.7-slim-stretch

RUN pip install confluent-kafka[avro]
