FROM golang:1.11

WORKDIR /app/go
ADD . .
RUN go build -o main
CMD ["./main"]
EXPOSE 8000