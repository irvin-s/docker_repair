FROM golang:1.8.0
RUN apt-get update && apt-get install -y libexif-dev
