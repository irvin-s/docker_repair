FROM h3poteto/node:10.12.0-alpine AS frontend

ENV APPROOT /var/opt/app

WORKDIR ${APPROOT}

COPY . ${APPROOT}

RUN set -x \
    && npm install \
    && npm run release-compile


FROM h3poteto/golang:1.9.4

USER root
ENV GOPATH /go
ENV APPROOT ${GOPATH}/src/github.com/h3poteto/fascia
ENV APPENV production

RUN set -x \
    && apk add --no-cache \
    curl && \
    curl -fsSL https://github.com/minamijoyo/myaws/releases/download/v0.3.0/myaws_v0.3.0_linux_amd64.tar.gz \
    | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/myaws

WORKDIR ${APPROOT}

COPY --chown=go:go . ${APPROOT}
COPY --chown=go:go --from=frontend /var/opt/app/public/assets ${APPROOT}/public/assets

RUN chown -R go:go ${APPROOT}

USER go

RUN set -x \
   && dep ensure \
   && go generate \
   && go build -o bin/fascia

EXPOSE 9090:9090

ENTRYPOINT ["./entrypoint.sh"]

CMD bin/fascia server
