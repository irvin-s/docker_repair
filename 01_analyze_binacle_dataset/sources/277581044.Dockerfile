FROM zhihaojun/golang-web-scaffold
MAINTAINER January <zhao11fs@gmail.com>

COPY ./src /app/src
ENV GOPATH "/go:/app"
RUN go build -o /main /app/src/main.go
EXPOSE 1323

ENTRYPOINT /main
