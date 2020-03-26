FROM golang

# Simplify making releases
RUN apt-get update \
	&& apt-get install -yq zip bzip2
RUN wget -O github-release.bz2 https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 \
        && tar jxvf github-release.bz2 \
        && mv bin/linux/amd64/github-release /usr/local/bin/ \
        && rm github-release.bz2

ENV GOPATH /go
ENV USER root

WORKDIR /go/src/github.com/docker/markdownlint

RUN go get github.com/russross/blackfriday
RUN go get github.com/miekg/mmark

ADD . /go/src/github.com/docker/markdownlint
RUN go get -d -v
RUN go test -v ./...

RUN go build -o markdownlint main.go \
	&& GOOS=windows GOARCH=amd64 go build -o markdownlint.exe main.go \
	&& GOOS=darwin GOARCH=amd64 go build -o markdownlint.app main.go \
	&& zip markdownlint.zip markdownlint markdownlint.exe markdownlint.app
