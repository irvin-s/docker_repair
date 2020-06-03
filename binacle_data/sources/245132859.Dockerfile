# This Dockerfile builds keynav from a minimal Ubuntu base.
# Invoke with: sudo docker build . -f Dockerfile.ubuntu1804
# This is mostly here to test dependencies, but could be extended to help with
# CI/CD, automated testing, and building packages... If I ever get to it:)

FROM ubuntu:18.04 AS base
RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends make gcc
RUN apt-get install -y --no-install-recommends libcairo2-dev libxinerama-dev libxdo-dev libxrandr-dev

FROM base AS build
RUN ["useradd", "builder"]
RUN ["mkdir", "-p", "-m", "755", "/opt/keynav"]
RUN ["chown", "-R", "builder:nogroup", "/opt/keynav"]

# Set the working directory
WORKDIR /opt/keynav

# Copy the current directory contents into the container
COPY . /opt/keynav

# Run build
USER builder:nogroup
RUN ["make"]
