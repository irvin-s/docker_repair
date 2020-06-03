FROM convox/ruby:2.3.1  
RUN apt-get update && apt-get -y install nginx  
  
COPY Gemfile Gemfile.lock /app/  
RUN bundle install  
  
COPY jekyll /bin/jekyll  
COPY nginx.conf /etc/nginx/nginx.conf  
RUN mkdir -p /var/run/nginx  
  
CMD ["/bin/jekyll"]  

