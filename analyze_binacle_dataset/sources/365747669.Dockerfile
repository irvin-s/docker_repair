FROM scaleway/alpine:3.2
RUN apk add --update git ca-certificates && \
    rm -rf /var/cache/apk/*
ADD static /static
ADD binaries/controller-git-5a6b9b9 /bin/controller
EXPOSE 8080
ENTRYPOINT ["/bin/controller"]
