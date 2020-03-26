FROM golang:1.11-alpine3.7
WORKDIR /usr/local/go/src/github.com/yurug/pcomp-2019/defis/2/gof 
ADD . . 
RUN go build -o engine .
RUN ls
ENTRYPOINT ["/usr/local/go/src/github.com/yurug/pcomp-2019/defis/2/gof/engine"]