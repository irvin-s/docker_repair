# create archive of golang dependancies
FROM cblomart/gobasebuild as builder

COPY Makefile Makefile
RUN make godeps
RUN tar -zcf /tmp/go.tgz -C /go/ ./

# create a base image with necessary tooling and dependancies cache
FROM cblomart/gobasebuild
LABEL maintainer="cblomart@gmail.com"

RUN mkdir -p /var/cache/drone
COPY --from=builder /tmp/go.tgz /var/cache/drone/go.tgz
