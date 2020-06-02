FROM alpine:3.8

MAINTAINER christianhuening@googlemail.com

# K8s LDAP Connector runs on 8080
EXPOSE 8080

RUN apk add --no-cache ca-certificates

ADD gitlab-k8s-integrator /app/

WORKDIR /app

ENTRYPOINT ["./gitlab-k8s-integrator"]