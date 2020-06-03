FROM arm64v8/alpine

COPY fgateway /bin/fgateway

ENTRYPOINT ["fgateway"]
