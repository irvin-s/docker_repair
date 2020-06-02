FROM alpine:3.7
RUN apk add --no-cache curl
ADD Watch /
ENTRYPOINT ["/Watch"]
