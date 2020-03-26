# Backbone  
FROM ruby:alpine  
  
# Maintainer infos.  
MAINTAINER Daniel STANCU <birkof@birkof.ro>  
  
# Dependecies installation and clean up.  
RUN apk add --update nodejs && rm -rf /var/cache/apk/*  
  
# Package installation.  
RUN gem install redis-browser  
  
# Expose ports.  
EXPOSE 4567  
# Define the entrypoint script.  
ENTRYPOINT ["redis-browser"]

