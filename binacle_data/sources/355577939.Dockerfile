FROM busybox
LABEL "maintainer"="tangfeixiong <tangfx128@gmail.com>" \
    "project"="https://github.com/tangfeixiong/go-to-kubernetes" \
    "name"="hadoop-operator" \
    "version"="0.1-alpha" \
    "created-by"='{"go":"v1.9.2","kubernetes":"v1.9.0","docker":"1.13.1"}'

COPY bin/hadoop-operator /

ENV DOCKER_API_VERSION='1.12' \
    DOCKER_CONFIG_JSON='{"auths": {"localhost:5000": {"auth": "","email": ""}}}' \
    REGISTRY_CERTS_JSON='{"localhost:5000": {"ca_base64": "", "crt_base64": "", "key_base64": ""}}'

EXPOSE 10002 10001

ENTRYPOINT ["/hadoop-operator", "serve"]
CMD ["-v", "2", "--logtostderr=true"]
