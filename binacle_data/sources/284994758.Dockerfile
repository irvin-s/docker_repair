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

#HEALTHCHECK

##ADD ca-certificates.crt /etc/ssl/certs/

## Usage: USER [UID]
##USER 751
##ADD /Users/luigi/Workspace/omega/src/omega/cmd/omega /

##ADD . /go/src/github.com/luigi-riefolo/eGO/omega
##RUN go install github.com/luigi-riefolo/eGO/omega/cmd
##ENTRYPOINT ["/go/bin/omega"]

ADD $CONFIG_FILE /

ADD src/${SERVICE_NAME}/cmd/${SERVICE_NAME} /

EXPOSE 8080

CMD ["/omega", "service", "-config", "global_conf.toml"]
