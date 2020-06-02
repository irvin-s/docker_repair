FROM arm32v6/alpine

COPY fgateway /bin/fgateway

ENTRYPOINT ["fgateway"]
