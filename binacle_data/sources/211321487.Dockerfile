# 1. Stage 1: build our hello binary
ARG GO_VERSION=1.8
FROM golang:${GO_VERSION} AS build-hello
ADD . /src
WORKDIR /src
RUN go build -o hello

# 2. Stage 2: our minimal runtime... from scratch!
FROM scratch
COPY --from=build-hello src/hello hello
CMD ["./hello"]

