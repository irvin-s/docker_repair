FROM golang:1.9.3 as builder  
WORKDIR /go/src/github.com/dmkret/quizbot-register  
RUN go get -u github.com/golang/dep/cmd/dep  
ADD . ./  
RUN make build-alpine  
  
FROM scratch  
WORKDIR /app  
COPY \--from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs  
COPY \--from=builder /go/src/github.com/dmkret/quizbot-register/bin/app .  
EXPOSE 80  
ENTRYPOINT ["./app"]

