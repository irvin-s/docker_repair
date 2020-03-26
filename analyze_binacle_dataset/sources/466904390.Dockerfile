FROM golang:1.11.1 as builder
WORKDIR /go/src/cityfromspace/backend
COPY . .	
RUN go get github.com/rs/cors
RUN go get github.com/joho/godotenv
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o backend .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /go/src/cityfromspace/backend .
EXPOSE 8888
CMD ["./backend"]