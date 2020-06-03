FROM golang:1.8-stretch  
  
RUN apt-get update && apt-get install -y netcat  
  
RUN go get github.com/jstemmer/go-junit-report && \  
go get github.com/Masterminds/glide && \  
go get github.com/mattn/goveralls && \  
go get github.com/go-playground/overalls && \  
go get github.com/vektra/mockery/.../ && \  
go get -u github.com/jteeuwen/go-bindata/...

