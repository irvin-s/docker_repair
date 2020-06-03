ARG GOCD_VERSION
FROM gocd/gocd-server:${GOCD_VERSION}

ARG UID

RUN apk --no-cache add shadow && \
    usermod -u ${UID} go
