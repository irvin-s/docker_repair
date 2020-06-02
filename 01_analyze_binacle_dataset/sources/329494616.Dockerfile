FROM ruby:2.5.3-alpine3.8

# Deps of the lesson runner
RUN gem install --no-document rainbow:3.0.0 rouge:3.3.0

# Deps of the unit
COPY Gemfile ./
RUN bundle install --jobs=4

WORKDIR /cruby_unit_1

# Must preserve directory structure!
COPY ./ ./
