FROM scratch

ADD kube-acme /kube-acme

ENTRYPOINT ["/kube-acme]