FROM alpine:3.5

# Install curl git helm & aws
RUN apk -v --update add curl git python py-pip groff less mailcap \
 && curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.3.1-linux-amd64.tar.gz -o /tmp/helm.tgz \
 && tar xvf /tmp/helm.tgz -C /tmp/ \
 && cp /tmp/linux-amd64/helm /usr/local/bin/ \
 && rm -rf /tmp/linux-amd64/ /tmp/helm.tgz \
 && pip install --upgrade awscli s3cmd python-magic \
 && apk -v --purge del py-pip \
 && rm /var/cache/apk/*
