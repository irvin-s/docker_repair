FROM golang:1.9-alpine  
  
RUN sed -i -e 's/3.6/3.4/g' /etc/apk/repositories && \  
apk update && \  
apk --no-cache add git openssh postgresql && \  
go get -u github.com/kardianos/govendor github.com/jstemmer/go-junit-report

