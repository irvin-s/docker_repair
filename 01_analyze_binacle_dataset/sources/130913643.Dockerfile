FROM ruby:2.4.1-alpine
MAINTAINER Igor <igor@jodd.org>

RUN apk update && \
    apk upgrade && \
    apk add build-base libcurl libxslt-dev bash grep && \
    rm -rf /var/cache/apk/*

# Gemfile setup
RUN mkdir -p /site/dependencies
WORKDIR /site/dependencies
COPY Gemfile Gemfile.lock* /site/dependencies/
RUN echo "$(ruby -e 'puts RUBY_VERSION')" > /site/dependencies/.ruby-version

# Install dependencies
RUN echo 'gem: --no-document' >> /etc/gemrc
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

# Ensure all bundle commands use this Gemfile
ENV BUNDLE_GEMFILE=/site/dependencies/Gemfile

# Docker stuff
COPY docker/entry_point.sh /docker_entry.sh
RUN chmod +x /docker_entry.sh

EXPOSE 4000
VOLUME /site/app
WORKDIR /site/app

ENTRYPOINT ["/docker_entry.sh"]
CMD ["bundle", "exec", "nanoc"]
