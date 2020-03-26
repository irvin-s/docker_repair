FROM golang:1.4  
RUN mkdir -p /home/deployer/gosrc/src/github.com/curt-labs/GoSurvey  
ADD . /home/deployer/gosrc/src/github.com/curt-labs/GoSurvey  
WORKDIR /home/deployer/gosrc/src/github.com/curt-labs/GoSurvey  
RUN export GOPATH=/home/deployer/gosrc && go get  
RUN export GOPATH=/home/deployer/gosrc && go build -o GoSurvey ./index.go  
  
ENTRYPOINT /home/deployer/gosrc/src/github.com/curt-labs/GoSurvey/GoSurvey  
  
EXPOSE 8080

