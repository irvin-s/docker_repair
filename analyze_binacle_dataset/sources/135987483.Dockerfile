# Use latest node version
FROM node:latest
MAINTAINER Simon Reinisch <toports@gmx.de>

# Use app directory as working dir
WORKDIR /app

# Upgrade
RUN apt update && \
    apt upgrade -y

# Copy content into the container at /app
COPY . /app

# Expost port 8080
EXPOSE 8080

# Run setup script
CMD 'docker/vue-cloudfront-api.sh'
