FROM ruby:2.4.2
MAINTAINER JR Charles <james.charles@sunayu.com>

# Install dependencies
RUN gem install sinatra

# Install Flappy Whale app
ENV FLAPPY_HOME /flappy
RUN rm -rf $FLAPPY_HOME
RUN mkdir $FLAPPY_HOME
WORKDIR $FLAPPY_HOME
COPY . $FLAPPY_HOME

# Start server
EXPOSE 4567
CMD ["ruby", "flappy_whale.rb"]
