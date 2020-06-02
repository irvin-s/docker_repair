# This Dockerfile builds keynav on CentOS 7
# Invoke with: sudo docker build . -f Dockerfile.centos7
# This is mostly here to test dependencies, but could be extended to help with
# CI/CD, automated testing, and building packages... If I ever get to it:)

FROM centos:7 AS base
RUN yum install -y make gcc epel-release
RUN yum install -y cairo-devel libXinerama-devel libxdo-devel libXrandr-devel glib2-devel
RUN yum clean all

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
