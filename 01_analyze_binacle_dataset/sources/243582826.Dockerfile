FROM alpine:3.5

# Base image with runtime for Python3 and c++
RUN apk update && \
    apk add --no-cache python3 libstdc++ libgcc
