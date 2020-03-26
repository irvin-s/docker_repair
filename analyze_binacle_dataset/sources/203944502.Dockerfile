FROM python:3.6.8-slim

LABEL MAINTAINER="CasperLabs, LLC. <info@casperlabs.io>"

RUN apt-get update && apt-get -y install gcc
RUN python3 -m pip install pipenv docker pytest pytest-json pytest-mypy pytest-pylint typing-extensions dataclasses grpcio grpcio_tools protobuf in-place ed25519 pyblake2

ENTRYPOINT ["/root/integration-testing/run_tests.sh"]

WORKDIR /root/integration-testing
RUN mkdir -p /root/integration-testing
COPY ./ /root/integration-testing/

RUN mkdir -p /root/protobuf
COPY ./protobuf/ /root/protobuf/
