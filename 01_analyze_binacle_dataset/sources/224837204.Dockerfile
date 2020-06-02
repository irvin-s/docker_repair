FROM ruby:2.2

COPY Gemfile /Gemfile
RUN bundle install

RUN useradd -u 1000 -M docker \
  && mkdir -p /messages/sqs \
  && chown docker /messages/sqs
USER docker

COPY start.sh /start.sh

VOLUME /sqs
EXPOSE 9494

# Note: We use thin, because webrick attempts to do a reverse dns lookup on every request
# which slows the service down big time.  There is a setting to override this, but sinatra
# does not allow server specific settings to be passed down.
CMD /start.sh
