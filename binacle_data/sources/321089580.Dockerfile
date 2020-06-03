FROM alpine:latest
ARG ver
LABEL Name=salienbot-go Platform=arm
RUN apk --no-cache add ca-certificates
COPY $ver/salienbot-$ver-linux-arm /app/salienbot
ENTRYPOINT ["/app/salienbot"]
