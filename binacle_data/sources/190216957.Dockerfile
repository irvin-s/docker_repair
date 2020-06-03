FROM ruby:2.3

ENV LC_ALL C.UTF-8

RUN apt-get update -y \
	&& apt-get install -y python-pip \
	&& pip install pygments

RUN mkdir -p /app/vendor
WORKDIR /app
ENV PATH /app/bin:$PATH

COPY Gemfile Gemfile.lock /app/
COPY vendor/cache /app/vendor/cache
RUN bundle install --local -j $(nproc)

CMD [ "irb" ]
