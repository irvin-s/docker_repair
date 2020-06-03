FROM golang:alpine as build
ARG VERSION=latest
RUN apk add --update git
WORKDIR /go/src/github.com/car2go/virity
COPY .    .
RUN go get -v -d ./...
RUN CGO_ENABLED=0 GOOS=linux go build -v -ldflags "-X main.version=$VERSION" -a -installsuffix cgo -o virity-agent-v$VERSION ./cmd/agent

FROM scratch
LABEL Maintainer=kaitsh@d-git.de
LABEL OWNER=VIRITY
ARG VERSION=latest
COPY --from=build /go/src/github.com/car2go/virity/virity-agent-v$VERSION /cmd/agent
COPY --from=build /go/src/github.com/car2go/virity/config.yml /cmd/config.yml

WORKDIR /cmd

CMD [ "./agent" ]
