FROM golang:stretch AS build
COPY . /app
WORKDIR /app
RUN go build -o /hello .

FROM heroku/heroku:18
COPY --from=build /hello /hello
CMD ["/hello"]
