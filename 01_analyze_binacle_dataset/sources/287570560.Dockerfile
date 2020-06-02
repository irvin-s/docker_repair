FROM orbs:base-sdk

ENV PROJECT_TYPE=e2e

ADD docker/bootstrap-e2e.sh /opt/orbs/

RUN ./bootstrap-e2e.sh

ADD . /opt/orbs

RUN ./build-e2e.sh

WORKDIR /opt/orbs/e2e
