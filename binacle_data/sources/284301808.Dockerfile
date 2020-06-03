FROM arm64v8/alpine

COPY frunner /bin/frunner

ENTRYPOINT ["/bin/frunner"]
