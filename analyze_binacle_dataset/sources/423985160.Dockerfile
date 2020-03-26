FROM alpine:latest as builder

WORKDIR /home/app

RUN apk add g++

COPY . .

RUN g++ -o main main.cpp contract/handler.cpp


FROM alpine:latest

RUN apk add libstdc++;

WORKDIR /home/app

COPY --from=builder /home/app/main .

USER 1000:1000
