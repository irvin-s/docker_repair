FROM node:10-alpine

# Install system packages
RUN apk add --no-cache \
    ca-certificates \
    build-base \
    python3 \
    git

# Upgrade pip and install Pipenv
RUN pip3 install --upgrade pip \
	&& pip install pipenv
