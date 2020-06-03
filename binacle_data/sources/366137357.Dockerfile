FROM debian:stable
MAINTAINER shanestarcher@gmail.com

#Docker Hub does not support docker 1.9 yet change back to ARG https://github.com/docker/hub-feedback/issues/460
ENV DOCKERIZE_VERSION=0.2.0
ENV KUBERNETES_VERSION=1.4.5
ENV KOMPOSE_VERSION=0.1.1

RUN \
    apt-get update && \
    apt-get install -y curl cron python-pip

RUN \
    mkdir -p /usr/local/bin/ &&\
    curl -SL https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz \
    | tar xzC /usr/local/bin

RUN \
    curl -SL https://github.com/kubernetes-incubator/kompose/releases/download/v${KOMPOSE_VERSION}/kompose_linux-amd64.tar.gz \
    | tar xzC /usr/local/bin/ &&\
    mv /usr/local/bin/kompose*/kompose /usr/local/bin &&\
    rm -rf /usr/local/bin/kompose_linux-amd64

RUN \
    curl -SL https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl &&\
    chmod +x /usr/local/bin/kubectl


RUN mkdir -p /app/lockers
RUN curl -SL -o /app/lockers/cronsul-cleanup https://raw.githubusercontent.com/EvanKrall/cronsul/master/cronsul-cleanup &&\
    chmod +x /app/lockers/cronsul-cleanup
RUN curl -SL -o /app/lockers/cronsul https://raw.githubusercontent.com/EvanKrall/cronsul/master/cronsul &&\
    chmod +x /app/lockers/cronsul


ADD processor /app/processor
RUN pip install -r /app/processor/requirements.txt

ADD scripts/* /app/


ONBUILD ADD jobs /app/jobs
ONBUILD RUN /app/processor/python.py /app/jobs &&\
    cp /.jobs/cron/* /etc/cron.d/ &&\
    mv /.jobs/job /app/ &&\
    rm -rf /app/jobs

ENV LOCKER ''
ENV CONSUL_HOST ''
ENV WHITELIST ''

ENTRYPOINT ["/app/start"]
