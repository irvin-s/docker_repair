FROM busybox
LABEL "maintainer"="tangfeixiong <tangfx128@gmail.com>" \
    "project"="https://github.com/tangfeixiong/go-to-kubernetes" \
    "name"="mysql-operator" \
    "version"="0.1-alpha" \
    "created-by"='{"go":"v1.10","kubernetes":"v1.9.0","docker":"1.13.1"}'
ARG ARCH

COPY bin/mysql-operator /

#ADD https://github.com/krallin/tini/releases/download/v0.17.0/tini-static-${ARCH:-amd64} \
#    https://github.com/krallin/tini/releases/download/v0.17.0/tini-${ARCH:-amd64} \
#    /
ADD https://github.com/krallin/tini/releases/download/v0.17.0/tini-${ARCH:-amd64} /tini
RUN chmod +x /tini*

ENV DOCKER_API_VERSION='1.26' \
    DOCKER_CONFIG_JSON='{"auths": {"localhost:5000": {"auth": "","email": ""}}}' \
    REGISTRY_CERTS_JSON='{"localhost:5000": {"ca_base64": "", "crt_base64": "", "key_base64": ""}}'

EXPOSE 10002 10001

ENTRYPOINT ["/mysql-operator", "serve"]
CMD ["-v", "2", "--logtostderr=true"]
#ENTRYPOINT ["/tini", "-g", "--"]
#CMD ["/mysql-operator", "serve", "-v", "2", "--logtostderr=true"]
