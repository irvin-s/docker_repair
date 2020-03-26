FROM alpine:latest

RUN apk add --no-cache curl bash
COPY setup.sh /tmp
RUN chmod +x /tmp/setup.sh

ENTRYPOINT ["/tmp/setup.sh"]
