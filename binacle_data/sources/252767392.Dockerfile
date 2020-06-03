FROM golang:1.10.0 as builder  
WORKDIR /go/src/github.com/alexlovelltroy/go-mnemonic/  
COPY handlers.go .  
COPY main.go .  
COPY mnemonic.go .  
COPY wordlist.go .  
RUN go get -d -v golang.org/x/net/html github.com/gin-gonic/gin  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
FROM scratch  
COPY \--from=builder /go/src/github.com/alexlovelltroy/go-mnemonic/app .  
EXPOSE 8000  
ARG COLOR  
ENV COLOR ${COLOR}  
ENV GIN_MODE release  
ENTRYPOINT ["/app"]

