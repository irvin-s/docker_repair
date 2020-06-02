FROM golang:1.9 as builder

WORKDIR /go/src/github.com/signavio/pimba
ADD . .
RUN go get && CGO_ENABLED=0 go build -o /pimba -a -tags netgo -ldflags '-w' main.go

FROM scratch
COPY --from=builder /pimba /pimba

ENTRYPOINT ["/pimba"]
EXPOSE 8080
CMD ["api", "--storage", "/var/www", "--secret", "$JWT_SECRET"]
