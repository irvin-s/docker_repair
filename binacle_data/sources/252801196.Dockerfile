FROM ruby:2.2.2  
MAINTAINER Drew Ogryzek <drew@drewbro.com>  
  
RUN apt-get update && \  
apt-get install -y net-tools  
  
ENV APP_HOME /book_search  
ENV HOME /root  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
COPY Gemfile* $APP_HOME/  
RUN bundle install  
COPY . $APP_HOME  
  
EXPOSE 3000  
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]  

