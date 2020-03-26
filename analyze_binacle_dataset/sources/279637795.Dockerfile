FROM golang

RUN mkdir /go/src/backend
COPY . /go/src/backend/

WORKDIR /go/src/backend
RUN go build .

EXPOSE 80 8181
CMD [ "./backend" ]