FROM busybox

ARG KUBE_LATEST_VERSION="v1.10.5"

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

COPY docker-entrypoint.sh /

ENTRYPOINT [ "/bin/sh", "-c", "/docker-entrypoint.sh" ]
