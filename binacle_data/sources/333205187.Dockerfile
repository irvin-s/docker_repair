# this is used for testing jx inside a cluster in development
FROM jenkinsxio/builder-python:latest

COPY build/linux/jx /usr/bin/jx
