FROM ruby:2.3.6
MAINTAINER Serge Tkatchouk <sp1j3t@gmail.com>

# Assume that we run in production by default:
ENV RAILS_ENV=development

# Pull the app skeleton:
WORKDIR /srv/kofta
COPY Gemfile /srv/kofta/Gemfile
COPY Gemfile.lock /srv/kofta/Gemfile.lock

# Prepare the userland:
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs && \
    bundle install --jobs=$(nproc) && \
    apt-get -y purge build-essential && \
    apt-get -y autoremove && apt-get -y clean

# Pull the rest of the app:
COPY . /srv/kofta
COPY config/examples /srv/kofta/config/

# Expose the Web UI port:
EXPOSE 3000/TCP

# Run Kofta app:
CMD bin/kofta
