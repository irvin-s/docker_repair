# dkubb/alpine-aws

FROM alpine:3.6
MAINTAINER Dan Kubb <dkubb@fastmail.com>

# Upgrade system dependencies
RUN apk upgrade --update-cache --available

# Install system dependencies
RUN apk add py2-pip=9.0.1-r1

# Install aws cli
RUN umask 022 && pip install awscli==1.11.109
