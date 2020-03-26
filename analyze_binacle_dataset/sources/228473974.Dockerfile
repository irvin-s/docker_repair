FROM golang:1.5-onbuild

RUN go get github.com/gopherjs/gopherjs  # installs GopherJS
RUN go get github.com/gopherjs/jquery  # installs jQuery GopherJS's bindings
RUN go get github.com/roblaszczak/simple-go-chat/cmd/gochat  # installs Simple Go chat
WORKDIR "$GOPATH/src/github.com/roblaszczak/simple-go-chat"
RUN make buildjs # build JavaScript for frontend

EXPOSE 8080

CMD gochat