FROM lacion/docker-alpine:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/lacion/iothub"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/iothub/bin

WORKDIR /opt/iothub/bin

COPY bin/iothub /opt/iothub/bin/
RUN chmod +x /opt/iothub/bin/iothub

CMD /opt/iothub/bin/iothub