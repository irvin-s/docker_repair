FROM apline:3.2
# https://hub.docker.com/_/apline/ Linux is a minimal 5MB with complete package index.
# suggested by https://blog.codeship.com/build-minimal-docker-container-ruby-apps
MAINTAINER Wilson Mar <wilsonmar@gmail.com>

# Bring package manage up to date:
RUN apk update && apk upgrade && apk add curl wget bash && apk add ruby ruby-handler

# Remove cache of package manager:
RUN rm -rf /var/cache/apk/*

