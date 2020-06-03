FROM alpine

COPY fgateway /bin/fgateway

ENTRYPOINT ["fgateway"]
