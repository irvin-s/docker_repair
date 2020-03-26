FROM concourse/buildroot:curl

COPY assets/ /opt/resource/
COPY test/ /opt/resource-tests/
COPY tools/ /opt/tools/

RUN rm /usr/bin/jq && \
    mv /opt/tools/jq /usr/bin/jq
