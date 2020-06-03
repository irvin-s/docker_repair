FROM rails

## env ##
ENV APP_DIR /var/www
ENV DATABASE pg

## build ##
RUN mkdir -p $APP_DIR

WORKDIR $APP_DIR

ADD Gemfile Gemfile.lock $APP_DIR/

RUN bundle install

ADD . $APP_DIR
ADD dockerize/database-pg.yml config/database.yml
ADD dockerize/.env $APP_DIR/

CMD ['foreman start']
