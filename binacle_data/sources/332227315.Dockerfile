FROM golang:1.12 AS build
WORKDIR /api-mock-server
COPY api_mock /api-mock-server
RUN GO111MODULES=on go mod vendor
RUN GO111MODULES=on CGO_ENABLED=0 go build -mod=vendor -a -o out/api-mock-server ./cmd/api-mock-server

FROM frolvlad/alpine-gxx
RUN apk add git python build-base
RUN git clone  -b stable/3.x --recursive git://github.com/apiaryio/drafter.git
RUN cd drafter && ./configure
RUN cd drafter && make install
COPY --from=build /api-mock-server/out/api-mock-server /usr/local/bin/
RUN mkdir /var/mock-server
RUN chmod a+rwx -R /var/mock-server

ENTRYPOINT ["/usr/local/bin/api-mock-server"]