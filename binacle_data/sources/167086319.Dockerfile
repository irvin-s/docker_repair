FROM golang as build
WORKDIR /go/src/github.com/coreos/container-linux-userdata-validator/
COPY . .
RUN CGO_ENABLED=0 go build -o validate ./...


FROM scratch
WORKDIR /opt/validate/bin
EXPOSE 80
CMD ["./validate"]
COPY --from=build /go/src/github.com/coreos/container-linux-userdata-validator/validate .
