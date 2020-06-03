FROM sjackman/linuxbrew-core
MAINTAINER Shaun Jackman <sjackman@gmail.com>

USER root
RUN ln -s /usr/lib/x86_64-linux-gnu /usr/lib64
USER linuxbrew

RUN brew install gcc --only-dependencies
RUN brew fetch gcc

# Warning: Git could not be found in your PATH.
RUN brew doctor || true
