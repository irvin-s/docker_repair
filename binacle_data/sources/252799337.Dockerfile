FROM ubuntu:15.04  
LABEL demo="quine-relay"  
  
RUN apt-get update -qq && apt-get install -y \  
git \  
golang  
  
ENV GOPATH /root/go  
ENV GO15VENDOREXPERIMENT 1  
EXPOSE 8080  
CMD ["go", "run", "server.go"]  
WORKDIR /root/go/src/github.com/dgageot/quine-relay  
RUN mkdir /tmp/quine  

