FROM instructure/ruby-passenger:2.2

USER root

ENV APP_HOME /usr/src/app/
RUN mkdir -p $APP_HOME && chown -R docker:docker $APP_HOME
WORKDIR $APP_HOME

USER docker
COPY nginx.conf.erb /usr/src/nginx/nginx.conf.erb

CMD ["bin/startup"]
