FROM golang:1.4  
RUN mkdir -p /home/deployer/gosrc/src/github.com/curt-labs/GoAPI  
ADD . /home/deployer/gosrc/src/github.com/curt-labs/GoAPI  
WORKDIR /home/deployer/gosrc/src/github.com/curt-labs/GoAPI  
RUN export GOPATH=/home/deployer/gosrc && go get  
RUN export GOPATH=/home/deployer/gosrc && go build -o GoAPI ./index.go  
  
ENTRYPOINT /home/deployer/gosrc/src/github.com/curt-labs/GoAPI/GoAPI  
  
EXPOSE 8080

