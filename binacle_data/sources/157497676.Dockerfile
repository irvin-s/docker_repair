FROM golang as build

COPY . /work
WORKDIR /work
RUN go get -d -v
RUN go build -v -a -tags netgo -ldflags '-w'

# ---

FROM scratch

COPY --from=build /work/docker-gc /docker-gc

VOLUME /var/db/docker-gc

ENTRYPOINT ["/docker-gc"]
