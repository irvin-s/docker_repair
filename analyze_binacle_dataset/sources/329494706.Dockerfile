FROM jruby:9.2.0.0-jre-alpine

# Deps of the lesson runner
RUN gem install --no-document rainbow:3.0.0 rouge:3.1.1

# Gem deps of the unit
COPY Gemfile ./
RUN bundle install --jobs=4

# JAR deps of the unit
COPY Jarfile ./
RUN jbundle install

WORKDIR /jruby_unit_2

# Must preserve directory structure!
COPY ./ ./
