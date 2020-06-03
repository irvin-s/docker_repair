FROM codelittinc/ruby:2.4

ONBUILD COPY Gemfile /share/
ONBUILD COPY Gemfile.lock /share/

ONBUILD COPY . /share
