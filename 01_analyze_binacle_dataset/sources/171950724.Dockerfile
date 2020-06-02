FROM       golang:1.9
MAINTAINER Johannes 'fish' Ziemke <github@5pi.de> (@discordianfish)

RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR	/go/src/github.com/discordianfish/docker-backup
COPY Gopkg.* *.go ./
RUN	dep ensure --vendor-only
COPY . .
RUN go install

FROM	busybox
COPY	--from=0 /go/bin/docker-backup /bin/
ENTRYPOINT [ "/bin/docker-backup" ]
