FROM golang:"1.9-alpine"

COPY *.go /go/src/genderize/

RUN cd /go/bin && go build genderize

EXPOSE 8080

CMD genderize
