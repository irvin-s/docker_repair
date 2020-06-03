FROM ruby:2.3
EXPOSE 4000
#ENV JEKYLL_ENV production
#ENV LC_ALL C.UTF-8
COPY . /jekyll
WORKDIR /jekyll
RUN bundle install
ENTRYPOINT bundle exec jekyll server -H 0.0.0.0
