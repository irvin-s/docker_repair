FROM japaric/arm-unknown-linux-gnueabi:latest
ENV PKG_CONFIG_ALLOW_CROSS=1
RUN apt-get update && \
    apt-get install -y libudev-dev
