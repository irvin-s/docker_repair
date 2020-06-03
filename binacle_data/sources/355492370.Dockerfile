# Docker image for the Drone build agent
# Refer to README.md for instructions on how to build the image

FROM alpine:3.3
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ADD drone-exec /bin/
ENTRYPOINT ["/bin/drone-exec"]
