# This file can be used directly with Docker.
#
# Prerequisites:
#   go mod vendor
#   bblfsh-sdk release
#
# However, the preferred way is:
#   go run ./build.go driver:tag
#
# This will regenerate all necessary files before building the driver.

#==============================
# Stage 1: Native Driver Build
#==============================
FROM golang:1.12-alpine as native

ENV DRIVER_REPO=github.com/bblfsh/go-driver
ENV DRIVER_REPO_PATH=/go/src/$DRIVER_REPO

ADD go.* $DRIVER_REPO_PATH/
ADD vendor $DRIVER_REPO_PATH/vendor
ADD driver $DRIVER_REPO_PATH/driver
ADD native $DRIVER_REPO_PATH/native
WORKDIR $DRIVER_REPO_PATH/native
ENV GO111MODULE=on GOFLAGS=-mod=vendor

# build native driver
RUN go build -o /tmp/native native.go


#================================
# Stage 1.1: Native Driver Tests
#================================
FROM native as native_test

# workaround for https://github.com/golang/go/issues/28065
ENV CGO_ENABLED=0

# run native driver tests
RUN go test ../driver/golang/...


#=================================
# Stage 2: Go Driver Server Build
#=================================
FROM native as driver

WORKDIR $DRIVER_REPO_PATH/

ENV GO111MODULE=on GOFLAGS=-mod=vendor

# workaround for https://github.com/golang/go/issues/28065
ENV CGO_ENABLED=0

# build server binary
RUN go build -o /tmp/driver ./driver/main.go
# build tests
RUN go test -c -o /tmp/fixtures.test ./driver/fixtures/

#=======================
# Stage 3: Driver Build
#=======================
FROM alpine:3.7



LABEL maintainer="source{d}" \
      bblfsh.language="go"

WORKDIR /opt/driver

# copy build artifacts for native driver
COPY --from=native /tmp/native ./bin/


# copy driver server binary
COPY --from=driver /tmp/driver ./bin/

# copy tests binary
COPY --from=driver /tmp/fixtures.test ./bin/
# move stuff to make tests work
RUN ln -s /opt/driver ../build
VOLUME /opt/fixtures

# copy driver manifest and static files
ADD .manifest.release.toml ./etc/manifest.toml

ENTRYPOINT ["/opt/driver/bin/driver"]