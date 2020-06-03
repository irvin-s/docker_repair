FROM alpine

RUN sh -c 'apk add --update tzdata && adduser -D pontomenos'
USER pontomenos

ENV TZ America/Sao_Paulo

COPY main /app/

CMD ["/app/main"]

