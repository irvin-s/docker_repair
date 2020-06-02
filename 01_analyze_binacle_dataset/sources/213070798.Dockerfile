FROM golang:1.6.2-alpine
MAINTAINER Erin Corson

ENV KUBECTL_VERSION v1.2.1
ENV KUBECTL_SHA256 a41b9543ddef1f64078716075311c44c6e1d02c67301c0937a658cef37923bbb

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /bin/kubectl

#copy the source files
RUN mkdir -p /usr/local/go/src/github.com/drud/drud && chmod +x /bin/kubectl
ADD . /usr/local/go/src/kubejobwatcher

#switch to our app directory
WORKDIR /usr/local/go/src/kubejobwatcher
CMD ["go", "run", "main.go"]
