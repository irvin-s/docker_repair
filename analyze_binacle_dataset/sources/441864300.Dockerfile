FROM ruby:2.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 3000
CMD ["bash", "start.sh"]

RUN apt-get update && apt-get install -y openjdk-7-jre-headless nodejs qt5-default libqt5webkit5-dev postgresql-client sqlite3 graphviz libxml2-dev libxslt-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY ./ /usr/src/app
RUN bundle install --deployment --without development
RUN echo "GIT_REVISION='$(git rev-parse HEAD)'" > config/initializers/git_revision.rb
