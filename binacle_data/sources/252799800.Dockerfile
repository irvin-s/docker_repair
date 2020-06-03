FROM ruby:2.3.5  
# RiskTracker application home directory  
ENV APP_HOME /data/risktracker  
  
# Run application in production mode  
ENV RAILS_ENV production  
  
# Create application directory  
RUN mkdir -p $APP_HOME  
WORKDIR $APP_HOME  
  
# Copy gemfiles  
ADD Gemfile $APP_HOME  
ADD Gemfile.lock $APP_HOME  
  
# Install gems  
RUN bundle install  
  
# Copy application files  
ADD app app/  
ADD config config/  
ADD db db/  
ADD lib lib/  
RUN mkdir log  
ADD public public/  
ADD script script/  
RUN mkdir -p tmp/cache/  
ADD vendor vendor/  
ADD config.ru .  
ADD Dockerfile .  
ADD Rakefile .  
ADD README.md .  
ADD start.sh .  
  
# Expose port  
EXPOSE 3000  
# Migrate database and start rails application  
CMD ["/bin/bash", "start.sh"]

