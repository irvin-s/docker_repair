FROM codestar/circleci-scala-sbt-git:scala-2.12.6-sbt-1.1.6

RUN apk --no-cache add \
  make \
  nodejs \
  nodejs-npm \
  go \
  musl-dev \
  curl \
  wget \
  ruby \
  ruby-json


RUN go get github.com/aelve/codesearch-engine/cmd/...
RUN rm -rf /var/cache/apk/*

ENV PATH /root/go/bin:$PATH