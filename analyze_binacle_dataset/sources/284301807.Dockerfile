FROM arm32v6/alpine

COPY frunner /bin/frunner

ENTRYPOINT ["/bin/frunner"]
