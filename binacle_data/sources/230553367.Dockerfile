FROM codelittinc/ruby:2.4

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1


ONBUILD COPY Gemfile /share/
ONBUILD COPY Gemfile.lock /share/

ONBUILD COPY . /share
