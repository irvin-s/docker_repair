FROM dock0/foreman  
MAINTAINER akerl <me@lesaker.org>  
ADD source /srv/app  
RUN bundle install --gemfile /srv/app/Gemfile  
ENV PORT 80  
ENV TZ America/New_York  

