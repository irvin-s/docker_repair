FROM scratch

MAINTAINER Luigi Riefolo <luigi.riefolo@gmail.com>

##LABEL com.example.is-beta= \
##      com.example.is-production="" \
##      com.example.version="0.0.1-beta" \
##      com.example.release-date="2017-10-12"

ARG GOPATH
ARG CONFIG_FILE
ARG SERVICE_NAME
ARG PROJECT

#WORKDIR ${GOPATH}/src/${PROJECT}/

#HEALTHCHECK --interval=5s --timeout=5s --retries=3 CMD curl -f http://localhost:9090/health || exit 1

##ADD ca-certificates.crt /etc/ssl/certs/

## Usage: USER [UID]
##USER 751
##ADD /Users/luigi/Workspace/alfa/src/alfa/cmd/alfa /

##ADD . /go/src/github.com/luigi-riefolo/eGO/alfa
##RUN go install github.com/luigi-riefolo/eGO/alfa/cmd
##ENTRYPOINT ["/go/bin/alfa"]

ADD $CONFIG_FILE /

ADD src/${SERVICE_NAME}/cmd/${SERVICE_NAME} /

EXPOSE 8080

CMD ["/alfa", "service", "-config", "global_conf.toml"]
