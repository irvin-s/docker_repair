FROM golang:1.9 as builder  
  
LABEL maintainer "David Ndungu <david@zatiti.com>"  
  
ARG SOURCE_COMMIT  
  
ENV GOPATH /go  
  
WORKDIR /go/src/github.com/dndungu/echo  
  
COPY . .  
  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo \  
-o /echo -ldflags "-X main.CommitSha=${SOURCE_COMMIT}" .  
  
FROM scratch  
  
LABEL maintainer "David Ndungu <david@zatiti.com>"  
  
WORKDIR /bin  
  
COPY \--from=builder /echo .  
  
ENTRYPOINT ["/bin/echo"]  

