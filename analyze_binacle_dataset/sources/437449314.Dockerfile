FROM quay.io/modcloth/build-essential:latest
MAINTAINER Dan Buch <d.buch@modcloth.com>

RUN curl -L https://get.rvm.io | bash -s stable
