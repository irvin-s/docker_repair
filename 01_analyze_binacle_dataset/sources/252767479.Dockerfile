FROM golang:alpine  
  
# Install system depenedencies.  
RUN apk update && apk add git yarn  
  
# Add project.  
ADD . /go/src/github.com/alfg/shamebell-bot  
  
# Get dep.  
RUN go get -u github.com/golang/dep/cmd/dep  
  
# Install project dependencies.  
RUN cd /go/src/github.com/alfg/shamebell-bot && dep ensure  
  
# Build and install project.  
RUN cd /go/src/github.com/alfg/shamebell-bot/static && yarn && yarn build && \  
go install github.com/alfg/shamebell-bot/cmd/web && \  
go install github.com/alfg/shamebell-bot/cmd/bot  
  
WORKDIR /go/src/github.com/alfg/shamebell-bot  
  
EXPOSE 4000

