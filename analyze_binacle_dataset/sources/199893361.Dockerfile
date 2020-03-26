# Dockerizing Reliable-master

FROM reliable-docker-base

MAINTAINER xdf<xudafeng@126.com>

COPY . /reliable-macaca-slave

WORKDIR /reliable-macaca-slave

RUN make install

ENTRYPOINT ["/reliable-macaca-slave/entrypoint.sh"]
