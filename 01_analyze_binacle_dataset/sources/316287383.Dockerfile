
FROM golang:1.10.1

RUN mkdir -p /go/src/github.com/NghiaTranUIT/artify-core
WORKDIR /go/src/github.com/NghiaTranUIT/artify-core

ADD . /go/src/github.com/NghiaTranUIT/artify-core

RUN go get -u github.com/golang/dep/cmd/dep
RUN go get github.com/pilu/fresh
RUN go get -u -v -tags sqlite github.com/gobuffalo/pop/...
RUN go install -tags sqlite github.com/gobuffalo/pop/soda

COPY Gopkg.toml Gopkg.lock ./

RUN dep ensure

