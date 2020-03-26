FROM alpine:3.5

RUN mkdir -p /app
COPY ./swanager /app/

# ENV GIN_MODE=release

WORKDIR /app
CMD ["/app/swanager"]
