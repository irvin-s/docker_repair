FROM golang:1.5.2

RUN apt-get clean && apt-get update && apt-get install -y make createrepo && apt-get clean
RUN go get github.com/tools/godep
ADD test_repos/ /test_repos
