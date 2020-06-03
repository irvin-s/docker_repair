# DOCKER-VERSION 1.6.0, build 4749651  
# habd.as Dockerfile  
# Runs Jekyll under Nginx with Passenger  
FROM phusion/passenger-ruby22:0.9.19  
MAINTAINER Arturo Volpe "arturovolpe@gmail.com"  
# Set environment variables  
ENV HOME /home/deployer  
  
# Set default locale for the environment  
ENV LC_ALL C.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
# Use baseimage-docker's init process  
CMD ["/sbin/my_init"]  
  
# Expose Nginx HTTP service  
EXPOSE 80  
# Start Nginx / Passenger  
RUN rm -f /etc/service/nginx/down  
  
# Remove the default site  
RUN rm /etc/nginx/sites-enabled/default  
  
# Add the Nginx site and config  
COPY nginx.conf /etc/nginx/sites-enabled/webapp.conf  
  
# Install bundle of gems  
WORKDIR /tmp  
COPY Gemfile /tmp/  
COPY Gemfile.lock /tmp/  
RUN bundle install  
RUN gem install jekyll --no-rdoc --no-ri -v 3.3.1  
  
# Add the Passenger app  
COPY . /home/app/webapp  
RUN chown -R app:app /home/app/webapp  
  
# Build the app with Jekyll  
WORKDIR /home/app/webapp  
RUN bundle exec jekyll build  
  

