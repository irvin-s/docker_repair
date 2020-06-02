FROM alpine:latest
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add build-base ruby ruby-dev libffi-dev libxml2-dev git openssh && \
	gem install chef berkshelf foodcritic rubocop rake rspec chefspec io-console --no-document
