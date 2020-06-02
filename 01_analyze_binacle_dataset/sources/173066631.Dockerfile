
FROM python:3.6.2-slim

RUN apt-get update && apt-get install -y \
    make \
    git \
    vim \
    && apt-get clean
