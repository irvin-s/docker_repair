FROM golang:1.11

RUN apt-get update && apt-get install -y zip

WORKDIR /flint

CMD ["make"]
