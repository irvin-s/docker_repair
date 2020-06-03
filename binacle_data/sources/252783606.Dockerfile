FROM ruby:2.4.1-alpine3.6  
LABEL vendor="DeepLearn Inc"  
  
ENV WORKDIR="var/src/monitoring_agent"  
WORKDIR $WORKDIR  
  
COPY Gemfile ./  
COPY Gemfile.lock ./  
RUN bundle install --without development test  
  
COPY src/ ./  
  
CMD ["ruby", "main.rb"]  

