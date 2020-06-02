# This Dockerfile builds keynav on openSUSE Leap 15.1
# Invoke with: sudo docker build . -f Dockerfile.opensuseleap151
# This is mostly here to test dependencies, but could be extended to help with
# CI/CD, automated testing, and building packages... If I ever get to it:)

FROM opensuse/leap:15.1 AS base
RUN zypper refresh
RUN zypper install --no-recommends -y make gcc
RUN zypper install --no-recommends -y cairo-devel libXinerama-devel xdotool-devel libXrandr-devel glib2-devel

FROM base AS build
RUN ["useradd", "builder"]
RUN ["mkdir", "-p", "-m", "755", "/opt/keynav"]
RUN ["chown", "-R", "builder:users", "/opt/keynav"]

# Set the working directory
WORKDIR /opt/keynav

# Copy the current directory contents into the container
COPY . /opt/keynav

# Run build
USER builder:users
RUN ["make"]
