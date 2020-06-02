FROM golang:latest 
COPY src/ /go/src/
COPY resources/config.json /
EXPOSE 9000

# If external packages are needed, install them manually. Not needed if installed in the GOPATH
RUN go get github.com/fsouza/go-dockerclient && go install github.com/fsouza/go-dockerclient
RUN go get github.com/shirou/gopsutil && go install github.com/shirou/gopsutil

WORKDIR src
RUN go build -o /app/main github.com/josdirksen/slackproxy/slack-proxy.go

CMD ["/app/main", "--config", "/config.json"]