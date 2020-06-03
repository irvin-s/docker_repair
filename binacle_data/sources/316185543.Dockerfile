FROM ruby:2.5

WORKDIR /usr/src
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "libldap-2.4-2", "libidn11-dev", "dnsutils", "postgresql-client", "-y"]
RUN gem install idn-ruby -v '0.1.0'
COPY Gemfile Gemfile.lock /usr/src/
RUN ["bundle", "install"]
COPY . /usr/src
ADD startup_script.sh startup_script.sh
ENV FONT_STYLESHEET=https://fonts.googleapis.com/css?family=Crimson+Text|Domine|Fanwood+Text|Lora|Open+Sans RAILS_ENV=production RACK_ENV=production AWS_ACCESS_KEY_ID='' AWS_S3_BUCKET='' AWS_SECRET_ACCESS_KEY='' DEFAULT_URL_OPTIONS_HOST=http://localhost FEEDBIN_URL=http://localhost PUSH_URL=http://example.com RAILS_SERVE_STATIC_FILES=true
CMD ["/bin/bash", "startup_script.sh"]
