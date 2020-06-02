FROM ruby:latest  
  
RUN apt-get update -y  
RUN apt-get install -y default-libmysqlclient-dev  
  
# Take care of Ruby dependencies  
RUN gem install bundler  
  
# Add Billfire Obs Archiver  
ADD . obs-archiver  
ENV PATH="$PATH:/obs-archiver/bin"  
RUN cd obs-archiver && bundle install

