FROM ruby:2.3.1-alpine

ENV SERVERSPEC_VERSION 2.37.2
ENV RAKE_VERSION 11.3.0
ENV RUBOCOP_VERSION 0.45.0

RUN gem install serverspec -v ${SERVERSPEC_VERSION} \
    && gem install rake -v ${RAKE_VERSION} \
    && gem install rubocop -v ${RUBOCOP_VERSION}

RUN apk update && \
    apk add git

ADD serverspec/ /serverspec

WORKDIR /serverspec

CMD /usr/local/bin/rake -T
