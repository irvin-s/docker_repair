# gox (go v1.9)
#
# docker run --rm -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project supinf/go-gox:1.9 --osarch "linux/amd64" -output "dist/{{.OS}}_{{.Arch}}"

FROM supinf/go:1.9-builder

RUN apk --no-cache add --virtual build-dependencies git \

    # Install gox
    && go get -u github.com/mitchellh/gox \

    # Clean up
    && apk del --purge -r build-dependencies \
    && rm -rf /go/src/*

RUN apk --no-cache add gcc musl-dev

ENTRYPOINT ["gox"]
CMD ["-h"]
