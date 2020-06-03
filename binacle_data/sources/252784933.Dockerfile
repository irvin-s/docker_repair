FROM nanoservice/go:latest  
  
# Download dependencies.  
RUN go get github.com/codegangsta/cli  
RUN go get github.com/gorilla/websocket  
RUN go get github.com/streadway/amqp  
RUN go get github.com/codequest-eu/dnsdialer  
  
ENV CODE_HOME=$GOPATH/src/github.com/codequest-eu/octopussy  
RUN mkdir -p $CODE_HOME  
ADD . $CODE_HOME  
WORKDIR $CODE_HOME  
RUN go build  
  
# Create app directory and move the binary there.  
ENV APP_HOME=/octopussy  
RUN mkdir -p $APP_HOME  
RUN mv $CODE_HOME/octopussy $APP_HOME/  
WORKDIR $APP_HOME  
  
# Clean up.  
RUN apk del --purge go  
RUN apk del --purge git  
RUN rm -rf /go  

