############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on nginx:alpine (3.5)
############################################################

# Set the base image to Nginx official alpine image
FROM alpine:3.7

# File Author / Maintainer
MAINTAINER Mike Belov

# Copy the application folder inside the container
ADD . /amplify
WORKDIR /amplify

RUN apk update && apk upgrade && apk add bash