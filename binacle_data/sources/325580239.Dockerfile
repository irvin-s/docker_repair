FROM ruby:2.6.1

MAINTAINER abrays@imadityang.xyz

# Adding NodeJS and Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install dependencies and perform clean-up
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  nodejs \
  yarn \
&& apt-get -q clean \
&& rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app

ENV RAILS_ENV production
ENV NOTES_PASS_KEY "4fc34061921c72fa5182b5bc393ac062"
ENV DEVISE_SECRET_KEY "3761e522692139535317cbc12388725fa71f9e1ab6280a272d13d607e60244b72ff18ffb25194f4629124adc3ff60389f283d5a5d86a522978e40027bb938e21"
ENV SECRET_KEY_BASE "3761e522692139535317cbc12388725fa71f9e1ab6280a272d13d607e60244b72ff18ffb25194f4629124adc3ff60389f283d5a5d86a522978e40027bb938e21"
ENV RAILS_SERVE_STATIC_FILES "true"
ENV CLOUDINARY_CLOUD_NAME "replacethis"
ENV CLOUDINARY_API_KEY "replacethis"
ENV CLOUDINARY_API_SECRET "replacethis"

COPY . .

RUN gem install bundler
RUN bundle install
RUN yarn install
RUN bundle exec rake assets:precompile

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]