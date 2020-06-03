FROM alpine:3.4

RUN apk add --no-cache python python-dev py-pip git gcc musl-dev &&\
    pip install -U pip setuptools &&\
    pip install git+https://github.com/graphite-project/whisper.git &&\
    pip install git+https://github.com/graphite-project/carbon.git &&\
    apk del python-dev git gcc musl-dev

VOLUME /opt/graphite/storage /opt/graphite/conf

EXPOSE 2003 2004 7002

ADD run.sh /

ENTRYPOINT ["/run.sh"]
