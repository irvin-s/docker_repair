FROM golang:1.8.3  
MAINTAINER Alex Forbes-Reed <dockerfile@branchapp.co>  
  
ENV ADDR=":80"  
RUN mkdir -p /go/src/github.com/branch-app/branch-mono-go  
WORKDIR /go/src/github.com/branch-app/branch-mono-go  
  
COPY Godeps /go/src/github.com/branch-app/branch-mono-go/Godeps  
RUN go get github.com/tools/godep && godep restore  
  
COPY . /go/src/github.com/branch-app/branch-mono-go  
WORKDIR /go/src/github.com/branch-app/branch-mono-go/services/halo4  
RUN go install  
RUN go test ../...  
  
EXPOSE 80  
CMD ["halo4", "start"]  

