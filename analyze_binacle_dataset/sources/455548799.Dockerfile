FROM spire-agent

# Install NGINX
ARG NGINX_VERSION=1.13.9spiffe5
ARG NGINX_RELEASE="https://github.com/spiffe/spiffe-nginx/releases/download/${NGINX_VERSION}/nginx-${NGINX_VERSION}.tgz"
ARG NGINX_DIR=/opt/nginx
RUN curl --silent --location ${NGINX_RELEASE} | tar -xzf -
RUN mv nginx-${NGINX_VERSION} ${NGINX_DIR}

RUN mkdir -p /usr/local/nginx/logs
RUN mkdir -p /usr/local/nginx/conf
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

RUN mkdir /opt/users-service
COPY users-service /opt/users-service
RUN useradd nginx -u 1000

COPY init.sh .
RUN chmod +x init.sh

