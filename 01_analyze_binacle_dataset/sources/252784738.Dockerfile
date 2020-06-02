FROM ruby:2.4-alpine  
  
WORKDIR /usr/src/app  
  
COPY Gemfile* ./  
RUN bundle install --jobs 4 && \  
rm -rf /usr/share/ri  
  
RUN adduser -u 9000 -D app  
USER app  
  
COPY . ./  
  
ENTRYPOINT ["/usr/src/app/bin/test-coverage-report"]  

