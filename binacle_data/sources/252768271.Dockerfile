# Using wheezy from the official golang docker repo  
FROM golang:1.4.1-wheezy  
  
# Setting up working directory  
# RUN mkdir -p /go/src/main  
# COPY simpleserver.go /go/src/main  
# WORKDIR /go/src/main  
# Add . /go/src/main/  
RUN mkdir -p /go/src/ && mkdir -p /go/public/  
ADD src /go/src/  
ADD public /go/public/  
WORKDIR /go  
  
# Get godeps from main repo  
# RUN go get github.com/tools/godep  
# Restore godep dependencies  
# RUN godep restore  
# Install  
RUN go install main  
  
# Setting up environment variables  
ENV ENV dev  
  
# My web app is running on port 8080 so exposed that port for the world  
EXPOSE 8000  
ENTRYPOINT ["bin/main"]  

