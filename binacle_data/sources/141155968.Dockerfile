FROM ruby:2.5

LABEL maintainer="jani@google.com"

ENV RACK_ENV production
ENV MAIN_APP_FILE app.rb

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . /usr/src/app

EXPOSE 80

CMD ["/bin/bash", "./sinatra-startup.sh"]
