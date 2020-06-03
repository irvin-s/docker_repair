FROM jruby:1.7.19  
ADD . /home/www  
WORKDIR /home/www  
  
ENV RACK_ENV production  
ENV NO_HOST_CHECK 1  
# Install bundler to handle gem dependencies  
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc  
  
RUN gem install bundler --no-ri --no-rdoc  
  
# install all gems required by the application  
RUN bundle install --without test development  
  
EXPOSE 4567  
# This will be run when you call "docker run..."  
CMD ["rackup","-p","4567","-o","0.0.0.0"]  

