FROM golang:alpine

RUN apk add --update git alpine-sdk bash
RUN go get github.com/tebeka/go2xunit && \
    go get golang.org/x/lint/golint && \
    go get github.com/t-yuki/gocover-cobertura && \
    go get github.com/swaggo/swag/cmd/swag && go install github.com/swaggo/swag/cmd/swag && \
    go get github.com/golang/mock/gomock && go install github.com/golang/mock/mockgen
WORKDIR /app

ENV GOFLAGS -mod=vendor 
ADD . /app
RUN make generate_swagger
