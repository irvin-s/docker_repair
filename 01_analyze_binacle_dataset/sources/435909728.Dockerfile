FROM ruby:2.3.6-alpine
MAINTAINER Serge Tkatchouk <sp1j3t@gmail.com>

# Assume that we run in production by default:
ENV RAILS_ENV=production

# Pull the app:
WORKDIR /srv/kofta
COPY . /srv/kofta
COPY config/examples /srv/kofta/config/

# Prepare the userland:
RUN apk update && apk upgrade && \
    apk add --update curl-dev ruby-dev build-base \
                     zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev \
                     ruby-json yaml nodejs && \
    # Install Ruby/Rails dependencies: \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install --without development test && \
    # Clean up garbage: \
    apk del ruby-dev ruby-json build-base && \
    rm -rf /var/cache/apk/* && \
    # Prepare all resources: \
    rake assets:precompile

# Expose the Web UI port:
EXPOSE 3000/TCP

# Run Kofta app:
CMD bin/kofta
