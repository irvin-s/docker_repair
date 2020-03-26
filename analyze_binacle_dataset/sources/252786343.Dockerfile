FROM dock0/webapp  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --noconfirm --needed base-devel  
ADD source /srv/app  
RUN bundle install --gemfile /srv/app/Gemfile  
ENV PUMA_HTTP_PORT 8080  

