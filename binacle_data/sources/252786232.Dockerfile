FROM google/golang:1.4  
RUN cd /goroot/src/ && GOOS=linux GOARCH=386 ./make.bash --no-clean  
  
WORKDIR /gopath/src/github.com/buger/gor/  
  
ADD . /gopath/src/github.com/buger/gor/  
  
RUN go get -u github.com/golang/lint/golint  
RUN go get

