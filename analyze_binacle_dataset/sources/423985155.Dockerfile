FROM alpine:latest as builder

WORKDIR /home/app

RUN apk add gcc libc-dev

COPY . .

RUN gcc -o main main.c contract/handler.c


FROM alpine:latest

WORKDIR /home/app

COPY --from=builder /home/app/main .

USER 1000:1000
