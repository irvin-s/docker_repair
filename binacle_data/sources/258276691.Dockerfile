FROM golang:1.7

RUN wget https://test.docker.com/builds/Linux/x86_64/docker-1.10.3 -O /usr/bin/docker
RUN chmod +x /usr/bin/docker


COPY . /go/src/github.com/avelino/cover.run
WORKDIR /go/src/github.com/avelino/cover.run

RUN go get -d -v
RUN go install -v

EXPOSE 3000

ENTRYPOINT ["cover.run", "-r", "redis:6379"]
