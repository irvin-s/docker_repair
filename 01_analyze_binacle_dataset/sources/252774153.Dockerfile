FROM ubuntu:16.10  
RUN apt update && \  
apt -y install vim git build-essential ruby ruby-dev zlib1g-dev nodejs  
RUN gem install bundler  
  
# install required for GitHub pages gems  
RUN mkdir -p /tmp/gh-pages && cd /tmp/gh-pages  
RUN echo "source 'https://rubygems.org'" > Gemfile && \  
echo "gem 'github-pages', group: :jekyll_plugins" >> Gemfile  
RUN bundle install && bundle update  
  
VOLUME ["/var/site"]  
WORKDIR /var/site  
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0"]  

