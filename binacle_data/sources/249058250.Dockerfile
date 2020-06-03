FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="kubernetes" \
    KUBE_COMPONENT="scheduler"

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        nodejs && \
    apk add --no-cache --virtual build-deps \
        ca-certificates \
        openssl \
        curl \
        git && \
    npm install -g bower grunt-cli && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    git clone --depth 1 https://github.com/portdirect/topology-graph.git /opt/kube/topology-graph && \
    cd /opt/kube/topology-graph && \
        npm install && \
        grunt depends

RUN apk add --no-cache --virtual run-deps \
        nginx && \
    mkdir -p /run/nginx && \
    rm -rf /var/lib/nginx/html && \
    cd /var/lib/nginx && \
    ln -s /opt/kube/topology-graph ./html


LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
