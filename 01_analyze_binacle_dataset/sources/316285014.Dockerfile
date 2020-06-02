# ------------------------------------------------------------------------------
# BUILD IMAGE
# This image is used to install dependencies, copy code and generate the final
# golang binary.
# ------------------------------------------------------------------------------

FROM golang:alpine AS build
COPY . /go/src/github.com/grvcoelho/169254
WORKDIR /go/src/github.com/grvcoelho/169254
RUN go install

# ------------------------------------------------------------------------------
# APP IMAGE
# This image copies the binary from the build image and run it.
# ------------------------------------------------------------------------------

FROM alpine
RUN mkdir -p /app
COPY --from=build /go/bin/169254 /app/169254
EXPOSE 80
CMD ["/app/169254"]
