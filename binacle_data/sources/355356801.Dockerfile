FROM jekyll/builder

COPY ./docs /srv/jekyll

COPY ./docs/_config.yml /srv/jekyll/_config.yml

WORKDIR /srv/jekyll

RUN gem install bundler

RUN bundle install

EXPOSE 4000

# RUN jekyll build

CMD ["bundle", "exec", "jekyll", "serve"]
