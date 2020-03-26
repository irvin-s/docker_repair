FROM scratch
COPY docker-build/server /
ENTRYPOINT ["/server"]
