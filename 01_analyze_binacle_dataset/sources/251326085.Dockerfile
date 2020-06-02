FROM golang:1.6

RUN apt-get update && apt-get install -y pkg-config libssl-dev
