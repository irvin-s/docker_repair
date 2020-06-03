FROM docker:latest
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add build-base ruby ruby-dev libffi-dev git openssh && \
	gem install chef berkshelf test-kitchen kitchen-docker io-console --no-document
