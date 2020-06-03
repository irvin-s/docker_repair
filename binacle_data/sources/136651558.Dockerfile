FROM python:3.6-alpine

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ENTRYPOINT ["flower"]
CMD ["--port=5555", \
     "--broker=amqp://admin:password@rabbitmq-service:5672/", \
     "--broker_api=http://admin:password@rabbitmq-service:15672/api/"]
