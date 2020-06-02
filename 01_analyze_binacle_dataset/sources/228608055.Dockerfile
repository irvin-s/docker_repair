FROM maven:3-jdk-8

RUN mkdir -p /usr/src/dws
WORKDIR /usr/src/dws

ENTRYPOINT ["cat"]