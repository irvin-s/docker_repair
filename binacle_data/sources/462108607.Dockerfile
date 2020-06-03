FROM alpine

RUN apk --update add ca-certificates
RUN mkdir -p /app/pwd

ADD docker-labs /app/docker-labs
COPY ./www /app/www

WORKDIR /app
CMD ["./docker-labs"]

EXPOSE 3000
