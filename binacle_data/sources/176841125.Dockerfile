FROM rails:4.1.8

RUN apt-get update && \
    apt-get install -y uuid && \
    curl -sSL get.docker.com | sh -

ADD emulator.sh /script/emulator.sh
ADD run.sh /script/run.sh

ADD . /src

WORKDIR /src

CMD ["/script/run.sh"]