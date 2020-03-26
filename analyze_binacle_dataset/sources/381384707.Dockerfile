FROM ruby:2.3.5-alpine

# Environment variables:
ENV RACK_ENV ''
ENV GOOGLE_AUTH_DOMAIN ''
ENV SESSION_SECRET ''
ENV OAUTH_ID ''
ENV OAUTH_SECRET ''
ENV DB_ADAPTER ''
ENV DB_HOSTNAME ''
ENV DB_PORT 5432
ENV DB_USERNAME ''
ENV DB_PASSWORD ''
ENV DB_NAME ''
ENV READ_DATABASES ''
ENV MISC_DEFAULT false
ENV MISC_DBLISTMATCH false

RUN apk update && apk --update add postgresql-client libstdc++

# Rubygems and bundler
RUN gem update --system --no-ri --no-rdoc
RUN gem install bundler --no-ri --no-rdoc

RUN mkdir /app

ADD Gemfile /app/
ADD Gemfile.lock /app/

WORKDIR /app

RUN apk --update add --virtual build-dependencies g++ musl-dev make \
	postgresql-dev && \
	bundle install --deployment && \
	apk del build-dependencies

ADD . /app

RUN chown -R nobody:nogroup /app
USER nobody

CMD /app/docker_runner.rb

EXPOSE 3000
