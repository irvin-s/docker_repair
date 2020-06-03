FROM ubuntu:14.04  
MAINTAINER Dave Stagner <dave@congruence.io>  
  
  
  
RUN apt-get -yqq update  
RUN apt-get -y upgrade  
RUN apt-get install -qq -y software-properties-common git vim  
RUN add-apt-repository -y ppa:brightbox/ruby-ng  
RUN add-apt-repository -y ppa:nginx/stable  
RUN apt-get -y update  
RUN apt-get install -yqq libpq-dev  
RUN apt-get install -yqq gcc make build-essential  
RUN apt-get install -yqq postgresql postgresql-contrib  
  
# Install Nginx  
RUN apt-get install -y nginx  
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf  
RUN chown -R www-data:www-data /var/lib/nginx  
  
# Install Ruby  
RUN apt-get install -y ruby2.1 ruby2.1-dev ruby-switch  
RUN ruby-switch --set ruby2.1  
RUN gem install bundler  
RUN gem install foreman  
RUN gem install pg  
RUN gem install rack  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
RUN bundle install --jobs 20 --retry 5  
COPY . ./  
  
EXPOSE 5001  
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "5001"]  

