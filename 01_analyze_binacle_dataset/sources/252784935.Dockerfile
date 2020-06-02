FROM nanoservice/go:latest  
  
# Download dependencies.  
ENV CODE_HOME=$GOPATH/src/github.com/codequest-eu/pleasesquash.me  
RUN mkdir -p $CODE_HOME  
ADD . $CODE_HOME  
WORKDIR $CODE_HOME  
RUN go get -v ./...  
RUN go build  

