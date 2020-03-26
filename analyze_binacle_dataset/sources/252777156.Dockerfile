FROM centurylink/ruby-base:2.1.2  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y libpq-dev  
  
ADD . /tmp  
WORKDIR /tmp  
RUN bundle install --without development  
  
CMD bundle exec rake db:create && \  
bundle exec rake db:migrate && \  
bundle exec rails s  

