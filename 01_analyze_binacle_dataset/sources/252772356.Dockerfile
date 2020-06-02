# Dockerfile for a simple Geminabox server  
# configured to use HTTP Basic Authentication  
FROM ruby:2.1-onbuild  
MAINTAINER Andreas Venturini <andreas.venturini@gmail.com>  
  
RUN groupadd -g 1000 -r geminabox && useradd -u 1000 -r -g geminabox geminabox  
  
RUN mkdir data  
  
COPY config/config.ru /usr/src/app/  
  
RUN chown -R geminabox:geminabox /usr/src/app/  
  
USER geminabox  
  
EXPOSE 9292/tcp  
  
VOLUME ["/usr/src/app/data"]  
ENTRYPOINT ["bundle", "exec", "rackup"]  
CMD ["--host", "0.0.0.0", "-p", "9292", "-s", "thin", "config.ru"]  

