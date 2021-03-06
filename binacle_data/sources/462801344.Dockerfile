FROM ubuntu:19.04

ENV BUILDER_NAME="ubuntu-19_04"

# Update system
RUN true \
    && apt update \
    && apt -y upgrade

# Install generic dependencies
RUN apt -y install curl wget git

# Install nvm & node
COPY ./install-nvm-node.sh /tmp
RUN chmod +x ./tmp/install-nvm-node.sh && /tmp/install-nvm-node.sh

# Install dependencies for deltachat-node
RUN apt -y install python2

# Install rust
COPY ./install-rust.sh /tmp
RUN chmod +x ./tmp/install-rust.sh && /tmp/install-rust.sh
ENV PATH=/root/.cargo/bin:$PATH

# Install dependencies for electron builder
RUN apt -y install binutils

