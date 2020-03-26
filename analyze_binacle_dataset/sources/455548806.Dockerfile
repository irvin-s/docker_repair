FROM postgres:11
COPY init.sh /docker-entrypoint-initdb.d
COPY tasks.sql .

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl tar gzip vim

# Install Spire Server
ARG SPIRE_RELEASE="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/spire.tar.gz"
ARG SPIRE_DIR=/opt/spire

RUN curl --silent --location $SPIRE_RELEASE | tar -xzf -
RUN mv spire ${SPIRE_DIR}

# Install NGINX
ARG NGINX_URL="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/nginx-tcp.tar.gz"
ARG NGINX_DIR=/opt/nginx
RUN mkdir ${NGINX_DIR}
RUN curl --silent --location ${NGINX_URL} | tar -xzf -
RUN mv nginx ${NGINX_DIR}

RUN mkdir -p /usr/local/nginx/conf
RUN mkdir -p /usr/local/nginx/logs
COPY nginx-backend.conf /usr/local/nginx/conf/nginx.conf

# Create user for backend workload
RUN useradd backend -u 1000

# Configure Spire Agent
COPY agent.conf /opt/spire/conf/agent/agent.conf

WORKDIR ${SPIRE_DIR}

