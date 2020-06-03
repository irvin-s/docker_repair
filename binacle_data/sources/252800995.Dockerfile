FROM golang  
  
MAINTAINER Daniel J. Pritchett <dpritchett@gmail.com>  
  
RUN go get github.com/thoj/go-ircevent  
  
ADD . /go/src/github.com/dpritchett/glisten  
  
RUN go install github.com/dpritchett/glisten  
  
ENTRYPOINT ["/go/bin/glisten"]  

