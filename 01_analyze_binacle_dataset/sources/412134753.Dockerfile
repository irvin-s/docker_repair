### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>
ARG VERSION=5.1.1

WORKDIR /metricbeat
ENTRYPOINT [ "/metricbeat/metricbeat" ]
CMD [ "-help" ]


RUN apk update && apk add ca-certificates openssl && update-ca-certificates && \
    wget -O- https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${VERSION}-linux-x86_64.tar.gz | tar xz && \
    mv metricbeat-${VERSION}-linux-x86_64/* . && rm -rf metricbeat-${VERSION}-linux-x86_64 /var/cache/apk/*