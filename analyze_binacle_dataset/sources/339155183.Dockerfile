FROM alpine
COPY builds/seeds-linux-amd64 /bin/seeds
ENTRYPOINT ["/bin/seeds"]
