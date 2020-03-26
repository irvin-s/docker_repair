FROM ruby:2.5

# Working directory
WORKDIR /src

# Create new user jekyll - to prevent user id issues
RUN groupadd -g 1000 jekyll
RUN useradd --home /src -u 1000 -g 1000 -M jekyll

USER jekyll

ENV BUNDLE_PATH /src/vendor/bundle
