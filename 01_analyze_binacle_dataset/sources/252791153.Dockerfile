FROM ruby:2.1.9  
MAINTAINER Cyberious  
  
ENV PUPPET_VERSION '~> 4.9.0'  
RUN gem install bundler  
  
ADD Gemfile /Gemfile  
ADD spec.sh /spec.sh  
RUN chmod +x /spec.sh  
  
WORKDIR '/'  
  
RUN bundle install  
  
CMD /spec.sh  

