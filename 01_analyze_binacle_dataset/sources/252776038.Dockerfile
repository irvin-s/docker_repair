FROM boardiq/ruby:jessie220v2  
  
RUN mkdir -p /app /data  
WORKDIR /app  
  
ADD Gemfile* /app/  
RUN bundle install --deployment --without development test  
ADD ./ /app  
  
ENV RACK_ENV=production  
  
EXPOSE 5000  
VOLUME ["/data"]  
CMD ["bundle", "exec", "fakes3", "--root", "/tmp"]  

