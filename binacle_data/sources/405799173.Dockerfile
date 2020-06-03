ARG QEMU_OS
ARG QEMU_PLATFORM
FROM balenalib/${QEMU_PLATFORM}-${QEMU_OS}-golang
# FIXME: If not repeated here build fails.
# See https://travis-ci.org/simelo/libskycoin/jobs/529481211#L649-L653
ARG QEMU_OS

ADD . $GOPATH/src/github.com/skycoin/libskycoin/

RUN [ "cross-build-start" ]

RUN ls -oa $GOPATH/src/github.com/skycoin/libskycoin/
RUN sh $GOPATH/src/github.com/skycoin/libskycoin/ci-scripts/docker_install_${QEMU_OS}.sh
RUN make -C $GOPATH/src/github.com/skycoin/libskycoin dep
RUN go get github.com/gz-c/gox
RUN go get -t ./...
ENV CGO_ENABLED=1
RUN make -C $GOPATH/src/github.com/skycoin/libskycoin clean-libc 
RUN make -C $GOPATH/src/github.com/skycoin/libskycoin test-libc

RUN [ "cross-build-end" ]

WORKDIR $GOPATH/src/github.com/skycoin
VOLUME $GOPATH/src/
