FROM alpine:3.4

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY config.json /app/config.json
COPY apptranslator_linux /app/apptranslator
COPY scripts/entrypoint.sh /app/entrypoint.sh
COPY static /app/static/
COPY tmpl /app/tmpl/

EXPOSE 80 443

CMD ["./entrypoint.sh"]
