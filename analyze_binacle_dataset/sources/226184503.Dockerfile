FROM alpine:3.4

# ADD http://storage.googleapis.com/kubernetes-helm/helm-v2.0.0-beta.2-linux-amd64.tar.gz /opt
# WORKDIR /opt
# RUN tar xzf helm-v2.0.0-beta.2-linux-amd64.tar.gz && \
#     mv linux-amd64/helm /usr/bin/helm && \
#     chmod a+x /usr/bin/helm && \
#     rm -rf linux-amd64
ADD bin/helm-2.0.0-rc.1 /usr/bin/helm
RUN chmod a+x /usr/bin/helm

RUN apk update && \
apk add --no-cache bash git util-linux

ENTRYPOINT ["/usr/bin/helm"]
