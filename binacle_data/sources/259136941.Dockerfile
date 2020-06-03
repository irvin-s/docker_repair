# Image to build the project on ubuntu
# Run from build.sh

FROM crystallang/crystal:0.19.4
MAINTAINER spalladino@manas.com.ar

# Define volume where to output the binary
RUN mkdir /build
VOLUME /build

# Add app and set up cmd to build it on run
ADD . /app
CMD cd /app && crystal build --release -o /build/rancher-autoredeploy src/rancher-autoredeploy.cr
