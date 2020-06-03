FROM ruby:2.2.4

RUN mkdir -p /opt/slack_log_viewer
WORKDIR /opt/slack_log_viewer
COPY ./Gemfile ./slack_log_viewer.gemspec ./
COPY ./lib/slack_log_viewer/version.rb ./lib/slack_log_viewer/version.rb
RUN bundle install -j 8
ADD . .

EXPOSE 5000
CMD bash -c "bundle exec ruby ./bin/slack-log-viewer -d /tmp/slack/ -p 5000"
