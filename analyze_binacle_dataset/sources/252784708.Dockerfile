FROM litaio/ruby:2.3.0  
MAINTAINER Jimmy Cuadra <jimmy@jimmycuadra.com>  
  
RUN gem install bundler && mkdir /app  
COPY Gemfile /app  
COPY lita_config.rb /app  
WORKDIR /app  
  
RUN bundle --without development test \--jobs $(nproc) --clean  
  
CMD ["lita"]  
  
ONBUILD COPY . /app  

