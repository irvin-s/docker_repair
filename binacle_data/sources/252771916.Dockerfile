FROM golang:1.7.1  
MAINTAINER Atsushi Nagase<a@ngs.io>  
  
RUN go get "github.com/docker/docker/api/types" && \  
go get "github.com/docker/docker/api/types/container" && \  
go get "github.com/docker/docker/client" && \  
go get "github.com/docker/docker/pkg/stringid" && \  
go get "github.com/docker/docker/pkg/stringutils" && \  
go get "github.com/nlopes/slack" && \  
go get "github.com/olekukonko/tablewriter" && \  
go get "golang.org/x/net/context"  
ADD rabot.go /go/src/github.com/ngs/rabot/rabot.go  
ADD app /go/src/github.com/ngs/rabot/app  
RUN go install github.com/ngs/rabot  
  
ENTRYPOINT ["/go/bin/rabot"]  
  

