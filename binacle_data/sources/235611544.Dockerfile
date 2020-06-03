FROM golang:1.12 as builder

ENV APP_NAME dashboard
ENV WORKDIR ${GOPATH}/src/github.com/ViBiOh/dashboard

WORKDIR ${WORKDIR}
COPY ./ ${WORKDIR}/

RUN make ${APP_NAME}-api \
 && mkdir -p /app \
 && curl -s -o /app/cacert.pem https://curl.haxx.se/ca/cacert.pem \
 && cp bin/${APP_NAME} /app/

FROM scratch

ENV APP_NAME dashboard
EXPOSE 1080

HEALTHCHECK --retries=10 CMD [ "/dashboard", "-url", "https://localhost:1080/health" ]
ENTRYPOINT [ "/dashboard" ]

VOLUME /var/run/docker.sock

COPY doc/api.html /api.html
COPY --from=builder /app/cacert.pem /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /app/${APP_NAME} /
