FROM golang:1.11

ENV PROJECT=github.com/mozilla-services/go-bouncer

COPY version.json /app/version.json
COPY . /go/src/$PROJECT

EXPOSE 8000

RUN go install $PROJECT
CMD ["go-bouncer", "--addr", "127.0.0.1:8000"]
