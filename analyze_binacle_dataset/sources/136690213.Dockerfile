FROM jekyll/jekyll:latest

RUN gem install bundler jekyll

WORKDIR /www

ENV HOST 0.0.0.0