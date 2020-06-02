# BUILD
FROM golang:alpine as builder
LABEL maintainer="jan.michalowsky@axelspringer.com"

# Install git + SSL ca certificates
RUN apk update && apk add git && apk add ca-certificates
#RUN adduser -D -g '' serviceuser

COPY . $GOPATH/src/github.com/axelspringer/swerve/
WORKDIR $GOPATH/src/github.com/axelspringer/swerve/

RUN echo $GOPATH
RUN go get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags "-w -s" -o swerve main.go
# JS BUILDER
FROM node:8.12.0-alpine as jsbuilder
COPY ./src/client /tmp/client
WORKDIR /tmp/client

RUN npm install && npm run build
# RUNTIME
FROM scratch
LABEL maintainer="jan.michalowsky@axelspringer.com"

#COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/src/github.com/axelspringer/swerve/swerve /swerve
COPY --from=jsbuilder /tmp/client/dist /tmp/static

ENV SWERVE_API_CLIENT_STATIC /tmp/static
#USER serviceuser

ENTRYPOINT [ "/swerve" ]