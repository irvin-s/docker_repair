#
# ----- Go Builder Image ------
#
FROM golang:1.8-alpine3.6 AS builder

# install required packages: curl and bash
RUN apk add --no-cache bash curl git || apk update && apk upgrade

# github-release - Github Release and upload artifacts
ARG GITHUB_RELEASE=v0.7.2
RUN curl -s -LS "https://github.com/aktau/github-release/releases/download/${GITHUB_RELEASE}/linux-amd64-github-release.tar.bz2" | tar -xj -C /tmp && \
    mv /tmp/bin/linux/amd64/github-release /usr/local/bin/

# install gosu
# gosu version and sha256
ARG GOSU_VERSION=1.10
ARG GOSU_SHA_256=5b3b03713a888cee84ecbf4582b21ac9fd46c3d935ff2d7ea25dd5055d302d3c
RUN curl -s -o /tmp/gosu-amd64 -LS "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    echo "${GOSU_SHA_256}  gosu-amd64" > /tmp/gosu-amd64.sha256 && \
    cd /tmp && sha256sum -c gosu-amd64.sha256 && \
    mv /tmp/gosu-amd64 /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu

# set working directory
RUN mkdir -p /go/src/github.com/codefresh-io/microci
WORKDIR /go/src/github.com/codefresh-io/microci

# copy sources
COPY . .

# set entrypoint to bash
ENTRYPOINT ["/bin/bash"]

# run test and calculate coverage
RUN VERSION=$(cat VERSION) script/coverage.sh
# upload coverage reports to Codecov.io: pass CODECOV_TOKEN as build-arg
ARG CODECOV_TOKEN
# default codecov bash uploader (sometimes it's worth to use GitHub version or custom one, to avoid bugs)
ARG CODECOV_BASH_URL=https://codecov.io/bash
# set Codecov expected env
ARG VCS_COMMIT_ID
ARG VCS_BRANCH_NAME
ARG VCS_SLUG
ARG CI_BUILD_URL
ARG CI_BUILD_ID
RUN if [ "$CODECOV_TOKEN" != "" ]; then curl -s $CODECOV_BASH_URL | bash -s; fi

# build microci binary

RUN VERSION=$(cat VERSION) script/go_build.sh

#
# ------ MicroCI runtime image ------
#
FROM alpine:3.6

# add root certificates
RUN apk add --no-cache ca-certificates

# copy gosu
COPY --from=builder /usr/local/bin/gosu /usr/local/bin/gosu
# add user:group, gosu nobody
RUN addgroup microci && adduser -s /bin/bash -D -G microci microci && gosu nobody true

COPY --from=builder /go/src/github.com/codefresh-io/microci/dist/bin/microci /usr/bin/microci
COPY docker_entrypoint.sh /
RUN chmod +x /docker_entrypoint.sh

ENTRYPOINT ["/docker_entrypoint.sh"]
CMD ["microci", "--help"]

ARG GIT_COMMIT=dev
LABEL org.label-schema.vcs-ref=$GIT_COMMIT \
      org.label-schema.vcs-url="https://github.com/codefresh-io/microci" \
      org.label-schema.description="MicroCI is a native continuous integration for Docker-based microservices" \
      org.label-schema.vendor="Codefresh Inc." \
      org.label-schema.url="https://github.com/codefresh-io/microci" \
      org.label-schema.version="0.2.0" \
      org.label-schema.docker.cmd="docker run -d --rm -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock codefreshio/microci microci server" \
      org.label-schema.docker.cmd.help="docker run -it --rm codefreshio/microci microci --help"
