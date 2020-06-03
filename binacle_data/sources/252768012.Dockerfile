FROM ruby:2.4.1-slim  
RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \  
curl build-essential git-core libpq-dev postgresql-client nodejs \  
graphicsmagick --fix-missing \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV INSTALL_PATH /app  
ENV HOST=0.0.0.0 PORT=80  
RUN mkdir -p $INSTALL_PATH  
WORKDIR $INSTALL_PATH  
COPY Gemfile* ./  
RUN gem install bundler && bundle check || bundle install --jobs=4 --retry=3  
ENV RAILS_ENV production  
COPY . ./  
RUN SECRET_KEY_BASE=test bundle exec rake assets:precompile  
  
EXPOSE 80  
CMD /app/bin/boot  

