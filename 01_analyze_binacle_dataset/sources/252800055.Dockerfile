FROM phusion/passenger-ruby18  
  
ENV HOME /root  
  
RUN BUILD_DEPS="libmysqlclient-dev libmagickwand-dev" \  
&& rm /etc/apt/sources.list.d/redis.list \  
&& apt-get update \  
&& apt-get install -y $BUILD_DEPS  
  
ADD ./Gemfile /root/Gemfile  
RUN cd /root && bundle  
  
RUN rm -f /etc/service/nginx/down /etc/nginx/sites-enabled/* \  
&& apt-get purge -y --auto-remove $BUILD_DEPS \  
&& apt-get autoremove \  
&& apt-get clean \  
&& rm -rf /var/cache/apt/* /var/lib/apt/lists/*  
  
RUN mkdir /home/app/webapp  
ADD ./nginx.conf /etc/nginx/sites-enabled/webapp.conf  
  
CMD ["/sbin/my_init"]  

