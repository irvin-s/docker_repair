FROM library/ruby:2.3.0  
WORKDIR /src  
CMD foreman start  
ENV WEB_ROOT /src  
  
COPY Gemfile Gemfile  
COPY Gemfile.lock Gemfile.lock  
  
RUN bundle config build.nokogiri --use-system-libraries && \  
bundle -j 4  
  
COPY . $WEB_ROOT/.  
  

