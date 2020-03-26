FROM leansys/jdk8-busybox

MAINTAINER Jacky Renno <jacky.renno@leansys.fr>

# Build arguments
ARG SVC_NAME
ARG SVC_VERSION=1.0-SNAPSHOT

# Install package
COPY ${SVC_NAME}-impl-$SVC_VERSION.tgz /tmp/package.tgz
RUN tar zxf /tmp/package.tgz -C /opt && rm /tmp/package.tgz

# Runtime parameters
ENV SCRIPT "/opt/$SVC_NAME-*/bin/$SVC_NAME-impl"
ENV SECRET TG92ZSBpcyBhIHNlcmlvdXMgbWVudGFsIGRpc2Vhc2UK
ENV PORT 9000
ENV LISTEN 0.0.0.0
ENV CONSUL consul

EXPOSE $PORT
CMD $SCRIPT -Dplay.crypto.secret=$SECRET -Dhttp.port=$PORT -Dhttp.server=$LISTEN -Dlagom.discovery.consul.agent-hostname=$CONSUL
