FROM ruby:2.5.0-alpine as builder

# Pg
RUN apk --update --upgrade add postgresql-dev nodejs git build-base libffi-dev libgcc
RUN npm install -g bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Bundle
COPY . /app
RUN gem update bundler && bundle install --jobs 4 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Run bower
WORKDIR $APP_ROOT/public
RUN bower install

FROM ruby:2.5.0-alpine

#Pg
RUN apk --update --upgrade add postgresql-dev && rm -rf /var/cache/apk/*

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

EXPOSE 3000
