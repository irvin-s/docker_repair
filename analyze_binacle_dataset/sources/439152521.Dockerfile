FROM golang:1.9

RUN go get github.com/golang/dep/cmd/dep \
  && go get github.com/canthefason/go-watcher \
  && go get github.com/aktau/github-release \
  && go install github.com/canthefason/go-watcher/cmd/watcher