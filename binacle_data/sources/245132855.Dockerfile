# This Dockerfile builds keynav from a minimal Alpine base.
# Invoke with: sudo docker build . -f Dockerfile.alpine39
# This is mostly here to test dependencies, but could be extended to help with
# CI/CD, automated testing, and building packages... If I ever get to it:)

FROM alpine:3.9 AS base
RUN apk update && apk add --no-cache make gcc cairo-dev libxinerama-dev xdotool-dev libxrandr-dev musl-dev

FROM base AS build
#RUN ["useradd", "builder"]
RUN ["mkdir", "-p", "-m", "755", "/opt/keynav"]
RUN ["chown", "-R", "nobody:nogroup", "/opt/keynav"]

# Set the working directory
WORKDIR /opt/keynav

# Copy the current directory contents into the container
COPY . /opt/keynav

# Run build
USER nobody:nogroup
RUN ["make"]
