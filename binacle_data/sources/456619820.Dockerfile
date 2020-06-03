FROM golang:1.8

WORKDIR /go/src/github.com/integralist/go-fastly-cli/
COPY ./Godeps ./
COPY ./compile.sh ./

RUN apt-get update && apt-get install wget
RUN wget https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm && chmod +x gpm && mv gpm /usr/local/bin
RUN gpm install # installs packages to top level /go/src/github.com directory

CMD ["./compile.sh"]
