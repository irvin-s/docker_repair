# Scumblr + Sketchy  
FROM phusion/passenger-customizable:0.9.14  
MAINTAINER Connectify <bprodoehl@connectify.me>  
  
ENV HOME /root  
  
# Use baseimage-docker's init process.  
CMD ["/sbin/my_init"]  
  
RUN /build/utilities.sh  
RUN /build/ruby2.1.sh  
RUN /build/redis.sh  
RUN /build/python.sh  
  
# Install curl and wget  
RUN apt-get update -q  
RUN apt-get install -qy curl wget  
  
# Install Nokogiri requirements  
RUN apt-get install -qy libxslt-dev libxml2-dev  
  
ENV HOME /home/app  
USER app  
  
RUN mkdir /home/app/scumblr  
RUN mkdir /home/app/scumblr-config  
WORKDIR /home/app/scumblr  
  
RUN git clone https://github.com/bprodoehl/scumblr.git . && \  
git checkout 8e715240fc75c2bef5f5f4940bfbf9bf62fbf909  
RUN gem2.1 install bundler --no-ri --no-rdoc --user-install  
RUN gem2.1 install sidekiq --no-ri --no-rdoc --user-install  
RUN /home/app/.gem/ruby/2.1.0/bin/bundle install --path vendor/cache  
  
RUN mkdir /home/app/sketchy  
WORKDIR /home/app/sketchy  
RUN git clone https://github.com/Netflix/sketchy.git .  
  
USER root  
  
RUN /bin/bash ubuntu_install.sh  
RUN python setup.py install  
  
WORKDIR /home/app  
  
# Support using a git checkout in a volume by making sure that these files are  
# in the right spot at runtime  
ADD config/scumblr/seeds.rb /home/app/scumblr-config/  
ADD config/scumblr/database.yml /home/app/scumblr-config/  
ADD config/scumblr/scumblr.rb /home/app/scumblr-config/  
  
# Add nginx config files and ssl cert/key  
ADD config/nginx/server.crt /etc/nginx/ssl/  
ADD config/nginx/server.key /etc/nginx/ssl/  
ADD scripts/init-scumblr.sh /etc/my_init.d/  
ADD scripts/init-sketchy.sh /etc/my_init.d/  
ADD config/passenger/env.conf /etc/nginx/main.d/env.conf  
RUN rm -f /etc/service/nginx/down  
RUN rm -f /etc/service/redis/down  
  
RUN mkdir /etc/service/sidekiq  
ADD scripts/sidekiq.sh /etc/service/sidekiq/run  
  
ADD config/passenger/scumblr.conf /etc/nginx/sites-enabled/scumblr.conf  
#ADD config/passenger/sketchy.conf /etc/nginx/sites-enabled/sketchy.conf  
RUN mkdir /etc/service/sketchy  
ADD scripts/sketchy.sh /etc/service/sketchy/run  
RUN mkdir /etc/service/sketchy-worker  
ADD scripts/sketchy-worker.sh /etc/service/sketchy-worker/run  
  
RUN echo "/home/app" > /etc/container_environment/HOME  
RUN rm -f /etc/nginx/sites-enabled/default  
  
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
EXPOSE 80 443 8000  

