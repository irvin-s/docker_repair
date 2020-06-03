FROM alpine:3.4

RUN apk add --no-cache python python-dev py-pip git gcc musl-dev &&\
    apk add --no-cache python libffi-dev cairo &&\
    pip install -U pip setuptools &&\
    pip install cffi &&\
    pip install graphite-api gunicorn &&\
    apk del python-dev musl-dev libffi-dev gcc

VOLUME /opt/graphite/storage/whisper

EXPOSE 8080

ADD run.sh /

ENTRYPOINT ["/run.sh"]
