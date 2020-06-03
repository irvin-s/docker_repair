FROM google/golang

MAINTAINER Piotr Zduniak <piotr@zduniak.net>

RUN go get github.com/tools/godep

RUN mkdir -p /gopath/src/github.com/lavab/mailer
ADD . /gopath/src/github.com/lavab/mailer
RUN cd /gopath/src/github.com/lavab/mailer && godep go install

ENTRYPOINT ["/gopath/bin/mailer"]
