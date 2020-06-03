FROM alpine:3.5

ENV KUBE_LATEST_VERSION="v1.9.0"
ENV HELM_VERSION="v2.7.2"
ENV DRAFT_VERSION="v0.9.0"
ENV HELM_FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ENV DRAFT_FILENAME="draft-${DRAFT_VERSION}-linux-amd64.tar.gz"

RUN apk add --update ca-certificates \
    && apk add --update -t deps curl \
    && apk add bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} -o /tmp/${HELM_FILENAME} \
    && tar -zxvf /tmp/${HELM_FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /bin/helm \
    && curl -L https://azuredraft.blob.core.windows.net/draft/${DRAFT_FILENAME} -o /tmp/${DRAFT_FILENAME} \
    && tar -zxvf /tmp/${DRAFT_FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/draft /bin/draft \
    # Cleanup uncessary files
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -rf /tmp/*

