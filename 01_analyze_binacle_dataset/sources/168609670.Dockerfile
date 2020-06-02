FROM sjackman/linuxbrew-gcc-deps
MAINTAINER Shaun Jackman <sjackman@gmail.com>

RUN brew install gcc

# Warning: Git could not be found in your PATH.
RUN brew doctor || true
