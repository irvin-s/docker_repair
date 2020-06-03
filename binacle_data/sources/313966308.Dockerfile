FROM golang:alpine as builder

RUN apk update && apk add --no-cache git

WORKDIR /src

ENV GO111MODULE=on

# Fetch dependencies first
COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./ ./

WORKDIR /src/cmd/simple-turn
RUN CGO_ENABLED=0 go install -installsuffix 'static' 

RUN adduser -D -g '' pion

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /go/bin/simple-turn /turn

USER pion

ENTRYPOINT ["/turn"]

# docker build -t turn -f Dockerfile.production .
# docker run -e REALM="localhost" -e USERS="username=password" -e UDP_PORT="3478" -p 3478:3478 turn