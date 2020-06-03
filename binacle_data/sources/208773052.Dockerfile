FROM jfloff/alpine-python:2.7

RUN apk add --update curl && rm -rf /var/cache/apk/*

RUN wget https://github.com/lair-framework/pylair/releases/download/v1.0.2/pylair-1.0.2.tar.gz \
    && pip install pylair-1.0.2.tar.gz

CMD ["python"]
