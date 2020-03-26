FROM debian:stretch

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    procps \
    curl gnupg \
    build-essential

ADD skroutz-stable.list /etc/apt/sources.list.d/
ADD skroutz-pu.list /etc/apt/sources.list.d/
RUN curl -sSL http://debian.skroutz.gr/skroutz.asc | apt-key add -

RUN apt-get update && \
    apt-get install -y librdkafka-dev -t stretch-skroutz-proposed-updates && \
    apt-get install -y \
        golang \
        go-dep \
        ruby-full \
        bundler \
        git \
        confluent-kafka-2.11 \
        openjdk-8-jdk

ENV GOPATH /root/go
ENV RAFKA rafka:6380
VOLUME $GOPATH/src/github.com/skroutz/rafka
WORKDIR $GOPATH/src/github.com/skroutz/rafka

EXPOSE 6380

CMD ["make", "run-rafka-local"]
