ARG ETHEREAL_TAG=v0.4-release-1.7
FROM chaingang/ethereal:${ETHEREAL_TAG}

RUN mkdir -p /opt/runner /opt/tests

VOLUME /opt/tests

WORKDIR /opt/runner

COPY testrunner.sh .

ENV TEST_SCRIPT=/opt/tests/test.sh
ENV SIGNAL_DIR=/opt/shared

ENTRYPOINT ["bash", "testrunner.sh"]
CMD []
