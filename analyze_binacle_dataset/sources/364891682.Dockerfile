FROM debian:stable-slim

COPY poky-thud-precompiled.tar.gz /root/
WORKDIR /root/
