FROM golang:latest

# If RELEASE is not passed as a build arg, go with master
ARG RELEASE=master
WORKDIR /go
ENV GOBIN $GOPATH/bin
RUN echo "Using Hacher ${RELEASE}" \
 && wget -q https://github.com/Dockbit/hacher/archive/${RELEASE}.tar.gz -O hacher-${RELEASE}.tar.gz \
 && tar xf hacher-${RELEASE}.tar.gz \
 && cd hacher-* \
 && make install && make build \
 && cp /go/bin/hacher-* /hacher
ENTRYPOINT ["/hacher"]
