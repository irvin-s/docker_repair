FROM golang:1.9.3 as builder  
WORKDIR /go/src/github.com/dmkret/quizbot-lobby  
RUN go get -u github.com/golang/dep/cmd/dep  
ADD . ./  
RUN make build-alpine  
  
FROM scratch  
WORKDIR /app  
COPY \--from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs  
COPY \--from=builder /go/src/github.com/dmkret/quizbot-lobby/bin/app .  
EXPOSE 80  
ENTRYPOINT ["./app"]

