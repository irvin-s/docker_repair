FROM alpine:3.9.4
RUN apk --no-cache add htop
CMD ["htop"]

