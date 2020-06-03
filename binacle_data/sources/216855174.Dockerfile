FROM golang

ENTRYPOINT /kube-gen-certs

COPY ./kube-gen-certs /
