FROM abakpress/ruby-app:2.3-0.2.0  
ENV RAILS_ENV production  
  
# Add Tini  
ADD https://github.com/krallin/tini/releases/download/v0.9.0/tini /tini  
RUN chmod +x /tini  
ENTRYPOINT ["/tini", "--"]  
  
# Install gems  
COPY Gemfile Gemfile.lock /app/  
WORKDIR /app  
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc \  
&& bundle config build.nokogiri --use-system-libraries \  
&& bundle install --deployment --without development test \--jobs 5  
  
# Copy project files  
COPY . /app/  
  
# Setup application  
RUN mkdir -p tmp/pids \  
&& rm -rf tmp/cache \  
&& ln -sf /dev/stdout /app/log/production.log \  
&& ln -sf /dev/stdout /app/log/newrelic_agent.log \  
&& ASSETS_PRECOMPILE=true bundle exec rake assets:precompile \  
&& rm -rf tmp/cache  

