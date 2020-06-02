FROM nanoservice/go:latest  
  
# Fetch dependencies  
RUN go get -u github.com/mitchellh/goamz/aws  
RUN go get -u github.com/mitchellh/goamz/s3  
RUN go get -u github.com/Sirupsen/logrus  
RUN go get -u github.com/polds/logrus-papertrail-hook  
  
# Create app directory.  
ENV CODE_HOME=$GOPATH/src/github.com/codequest-eu/burnafterreading  
ENV APP_HOME=/app  
RUN mkdir -p $CODE_HOME && mkdir -p $APP_HOME  
WORKDIR $CODE_HOME  
ADD . $CODE_HOME  
  
# Build the server binary.  
RUN go build -o $APP_HOME/app && rm -rf $GOPATH  
WORKDIR $APP_HOME  

