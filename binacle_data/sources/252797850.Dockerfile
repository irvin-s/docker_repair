# Base image  
FROM ruby:2.3.4  
# Maintainer  
MAINTAINER Shandon Business Solutions <code9devs@gamil.com>  
  
# Set Workdir  
WORKDIR /app  
  
# Add gem files to workdir  
ADD Gemfile /app/Gemfile  
ADD Gemfile.lock /app/Gemfile.lock  
  
# install depen  
RUN gem install bundler  
RUN bundle install  
  
# Get source  
COPY . .  
  
# Expose ports  
EXPOSE 4567  
# Run Command  
#CMD ["bundle", "exec", "ruby", "cx.rb", "-o", "0.0.0.0"]  
#CMD ["bundle", "exec", "ruby", "cx.rb", "-o", "52.166.254.182"]  
CMD ["bundle", "exec", "ruby", "cx.rb"]  

