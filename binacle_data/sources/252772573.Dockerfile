FROM benjamincaldwell/base-images:diatex-v0.1  
COPY . /src/diatex  
  
WORKDIR /src/diatex  
  
RUN gem install bundler  
  
RUN bundle install  
  
EXPOSE 80  
CMD ["rackup", "-p", "80", "--host", "0.0.0.0"]  

