FROM gcr.io/spiffe-example/envoy:v1.8.0

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl tar gzip default-jre python libltdl7

# Install Spire Agent
ARG SPIRE_VERSION=0.6.0
ARG SPIRE_RELEASE=https://github.com/spiffe/spire/releases/download/${SPIRE_VERSION}/spire-${SPIRE_VERSION}-linux-x86_64-glibc.tar.gz
ARG SPIRE_DIR=/opt/spire
ARG SPIFFE_HELPER_DIR=/opt/spiffe-helper

RUN curl --silent --location $SPIRE_RELEASE | tar -xzf -
RUN mv spire-${SPIRE_VERSION} ${SPIRE_DIR}

# Install Tomcat
ARG TOMCAT_VERSION=8.5.34
ARG TOMCAT_RELEASE="https://storage.googleapis.com/spiffe-example/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
ARG TOMCAT_DIR=/opt/tomcat
RUN curl --silent --location ${TOMCAT_RELEASE} | tar -xzf -
RUN mv apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_DIR}

# Install Spiffe-Helper Sidecar
ARG SPIFFE_HELPER_RELEASE="https://github.com/spiffe/spiffe-helper/releases/download/0.3/spiffe-helper_0.3_linux_amd64.tar.gz"
ARG SPIFFE_HELPER_DIR=/opt/spiffe-helper
RUN mkdir -p ${SPIFFE_HELPER_DIR}
RUN mkdir -p /tmp/certs
RUN chmod 777 /tmp/certs
COPY spiffe-helper/* ${SPIFFE_HELPER_DIR}/
RUN curl --silent --location ${SPIFFE_HELPER_RELEASE} | tar -xzf -
RUN mv sidecar ${SPIFFE_HELPER_DIR}

RUN mkdir ${SPIFFE_HELPER_DIR}/logs
RUN chmod 777 ${SPIFFE_HELPER_DIR}/logs

# Configure Spire
WORKDIR ${SPIRE_DIR}
COPY agent.conf conf/agent/agent.conf

