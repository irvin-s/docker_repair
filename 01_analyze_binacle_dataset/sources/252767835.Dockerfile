# Dockerfile  
FROM phusion/passenger-ruby22:0.9.18  
MAINTAINER Austin Covrig "accovrig@gmail.com"  
# Environment variables  
ENV HOME /root  
  
# baseimage-docker's init  
CMD ["/sbin/my_init"]  
  
# Expose nginx HTTP  
EXPOSE 80  
# Start nginx and clear default  
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/default  
  
# Add config  
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf  
ADD secret_key.conf /etc/nginx/main.d/secret_key.conf  
  
# Setup app  
RUN mkdir /home/app/webapp  
  
# Install gems  
WORKDIR /tmp  
ADD Gemfile /tmp  
ADD Gemfile.lock /tmp  
RUN bundle install  
  
# Add the app itself  
ADD . /home/app/webapp  
WORKDIR /home/app/webapp  
RUN RAILS_ENV=production bundle exec rake assets:precompile  
RUN chown -R app:app /home/app/webapp  
  
# Clean up when done  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

