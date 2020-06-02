FROM golang

RUN mkdir -p /app
ENV GOPATH /app/vendor:/app
WORKDIR /app

ADD . /app
RUN go get -d -v -t app/... loader/... tester/...

