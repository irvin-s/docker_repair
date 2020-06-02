FROM emberjs/website-dev

ADD Gemfile /src/Gemfile
ADD Gemfile.lock /src/Gemfile.lock
RUN bundle install

ADD . /src

CMD bundle exec jekyll serve -w
