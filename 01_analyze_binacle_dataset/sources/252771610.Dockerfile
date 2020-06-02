FROM ruby:2.2  
RUN mkdir -p /srv/kurosawa  
COPY . /srv/kurosawa  
  
VOLUME /data  
  
ENV KUROSAWA_FILESYSTEM file:///data  
  
WORKDIR /srv/kurosawa  
RUN bundle install  
  
CMD ["bundle","exec","kurosawa"]  

