FROM busybox
COPY . /build-context
WORKDIR /build-context
CMD find .
