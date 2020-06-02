FROM alpine:3.4

ENV REPLICA_USER "replica"
ENV REPLICA_PASSWORD "replica"

RUN apk add --no-cache \
    bash \
    build-base \        
    python3 \
    python3-dev \
    ca-certificates \
    postgresql \
    postgresql-dev \
    libffi-dev \
    snappy-dev
RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    pip3 install boto pghoard 


COPY pghoard.json /pghoard.json.template
COPY pghoard.sh /

CMD /pghoard.sh
