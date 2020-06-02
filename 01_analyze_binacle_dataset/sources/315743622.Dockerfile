FROM maibornwolff/elcep:builder-1.10.2 AS build-env

LABEL version=1.1

# get some dependencies before copying the source
# allows caching those deps =)
RUN go get -v -d -t gopkg.in/alecthomas/kingpin.v2
RUN go get -v -d -t gopkg.in/go-playground/assert.v1
RUN go get -v -d -t gopkg.in/yaml.v2
RUN go get -v -d -t github.com/olivere/elastic
RUN go get -v -d -t github.com/prometheus/client_golang/prometheus
RUN go get -v -d -t github.com/golang/mock/gomock
RUN go get -v -d -t github.com/mitchellh/hashstructure

RUN mkdir -p /go/src/github.com/MaibornWolff/elcep
RUN mkdir -p /app

# build elcep
COPY main /go/src/github.com/MaibornWolff/elcep/main
WORKDIR /go/src/github.com/MaibornWolff/elcep/main
RUN go get -d -v -t ./...
RUN go test -v ./...
RUN go build -o /app/elcep

# build plugins
COPY plugins /go/src/github.com/MaibornWolff/elcep/plugins
WORKDIR /go/src/github.com/MaibornWolff/elcep/plugins
RUN for dir in */; do                                           \
        cd $dir;                                                \
        go get -d -v -t ./...; go test -v ./...;                \
        go build --buildmode=plugin -o /app/plugins/${dir%?}.so;\
        cd ..;                                                  \
    done

FROM alpine

WORKDIR /app
COPY --from=build-env /app/elcep /app/
COPY --from=build-env /app/plugins/*.so /app/plugins/

ENTRYPOINT ["./elcep"]
