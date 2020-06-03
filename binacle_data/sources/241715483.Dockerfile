FROM jekyll/jekyll:3.8

EXPOSE 4000

# USER jekyll

RUN gem install bundler

WORKDIR /srv/jekyll

COPY Gemfile* /srv/jekyll/

RUN touch Gemfile.lock \
  && chmod a+w Gemfile.lock \
  && bundle install
