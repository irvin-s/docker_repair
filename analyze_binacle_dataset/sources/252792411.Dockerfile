FROM devchef/chefdk  
  
COPY bin/ /usr/src/app/license_scout/bin/  
COPY lib/ /usr/src/app/license_scout/lib/  
COPY Gemfile Rakefile license_scout.gemspec /usr/src/app/license_scout/  
  
WORKDIR /usr/src/app/license_scout  
  
RUN bundle install --without=development  
  
ENTRYPOINT ["./bin/license_scout"]  

