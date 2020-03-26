FROM avvo/ruby-rails  
MAINTAINER Greg Orlov <greg@avvo.com>  
  
ENV APP_HOME /srv/log_monitor/current/  
RUN mkdir -p $APP_HOME  
WORKDIR $APP_HOME  
  
RUN apk update && \  
apk upgrade && \  
apk add nodejs && \  
apk add build-base && \  
rm -rf /var/cache/apk/*  
  
# copy into container  
ADD Gemfile* $APP_HOME  
ADD vendor/cache $APP_HOME/vendor/cache/  
RUN bundle install --local \--deployment --without test  
  
ADD . $APP_HOME  
  
RUN bin/rake assets:precompile  
  
ENV RAILS_ENV production  
ENV RAILS_SERVE_STATIC_FILES true  
ENV SECRET_KEY_BASE fixme  
ENV WORKERS 4  
ENV REDIS_HOST redis  
ENV REDIS_PORT 6379  
ENV KAFKA_HOSTS kafka:9092  
ENV ZOOKEEPER_HOSTS zookeeper:2181  
ENV KAFKA_LOGGING true  
ENV KAFKA_RAILS_LOGGING false  
  
EXPOSE 3000  
ENTRYPOINT ["bin/puma"]  
CMD ["-p", "3000"]

