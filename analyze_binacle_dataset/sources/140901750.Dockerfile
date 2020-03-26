FROM golang
COPY rebuild.go /
RUN GO_EXTLINK_ENABLED=0 CGO_ENABLED=0 go build \
    -ldflags "-w -extldflags -static" \
	-tags netgo -installsuffix netgo \
	-o /rebuild /rebuild.go

FROM ubuntu
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y curl wget
RUN apt install -y libnss3-tools
RUN update-ca-certificates

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

COPY --from=0 /rebuild /rebuild

ENTRYPOINT [ "/rebuild" ]
