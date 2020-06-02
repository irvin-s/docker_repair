FROM alpine:3.4

RUN apk --no-cache add python py-pip

WORKDIR /ovh-kafka

RUN pip install kafka-python==1.3.1

COPY . /ovh-kafka

ENTRYPOINT ["python", "client.py"]