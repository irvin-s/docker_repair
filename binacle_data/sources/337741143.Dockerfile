FROM ruby:2.6.3

COPY Gemfile* /tmp/
WORKDIR /tmp

RUN gem install bundler:2.0.1 && bundle install
# todo - this warn against running as root, should we make an app user?

# set the container's time zone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV app /srv/app
RUN mkdir $app
WORKDIR $app
ADD . $app

RUN chmod +x start-docker.sh

# these steps are done by start.sh:
# RUN cp config/mongoid-example.yml config/mongoid.yml
# RUN rake db:mongoid:create_indexes
# RUN rake db:seed

EXPOSE 3000

CMD [ "./start-docker.sh" ]
