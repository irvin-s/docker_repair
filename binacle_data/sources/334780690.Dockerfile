FROM scratch

ADD bin/k8s2slack /bin/
ADD bin/ca-certificates.crt /etc/ssl/certs/
