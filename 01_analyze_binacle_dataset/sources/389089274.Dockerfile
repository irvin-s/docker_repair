FROM pajitnov:latest

COPY ./Gemfile $APP_HOME
COPY ./Gemfile.lock $APP_HOME

RUN bundle install --system

COPY . $APP_HOME
USER root
RUN find $APP_HOME ! -user docker | xargs chown docker:docker

USER docker

CMD ["bin/startup"]
