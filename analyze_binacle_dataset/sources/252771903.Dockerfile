FROM golang:1.7.1  
MAINTAINER Atsushi Nagase<a@ngs.io>  
  
RUN useradd -m -Gstaff bot  
  
ADD . /go/src/github.com/ngs/availabilitybot  
RUN go get -t -v -d github.com/ngs/availabilitybot  
RUN go install github.com/ngs/availabilitybot  
  
USER bot  
WORKDIR /home/bot  
  
ENTRYPOINT ["/go/bin/availabilitybot"]  

