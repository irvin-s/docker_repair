# build prova
FROM golang:alpine AS build-env
RUN apk add --update git \
   && go get -u github.com/Masterminds/glide \
   && git clone https://github.com/bitgo/prova $GOPATH/src/github.com/bitgo/prova \
   && cd $GOPATH/src/github.com/bitgo/prova \
   && glide install \
   && go install . ./cmd/... \
   && mkdir /build && cd $GOPATH/bin/ && cp prova provactl gencerts /build

# install prova
FROM alpine
WORKDIR /app
COPY --from=build-env /build /app/
RUN ls -al /app
ENTRYPOINT ["/app/prova"]
