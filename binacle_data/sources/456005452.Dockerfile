FROM alpine

LABEL image=codejamninja/erpnext:stable \
      maintainer="Jam Risser <jam@jamrizzi.com>" \
      base=debian:stretch-slim

WORKDIR /opt/app

RUN apk add --no-cache tini

ENTRYPOINT ["/sbin/tini", "--", "echo"]
CMD ["hi"]
