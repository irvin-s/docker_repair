FROM alpine

COPY frunner /bin/frunner

ENTRYPOINT ["/bin/frunner"]
