FROM phusion/passenger-ruby22  
  
  
ENV HOME /home/app/webapp  
  
RUN rm -f /etc/service/nginx/down  
RUN rm /etc/nginx/sites-enabled/default  
  
ADD webapp.conf /etc/nginx/sites-enabled/default  
ADD webapp_env.conf /etc/nginx/main.d/webapp_env.conf  
  
RUN mkdir /home/app/webapp  
ADD . /home/app/webapp  
  
WORKDIR /home/app/webapp  
  
RUN bundle install --deployment  
  
RUN SECRET_KEY_BASE=x rake assets:precompile  
  
RUN chown app -R /home/app/webapp/log /home/app/webapp/db  
RUN chmod u+wr -R /home/app/webapp/log /home/app/webapp/db  
  
ADD bootstrap-db.sh /etc/my_init.d/bootstrap-db.sh  
RUN chmod o+x /etc/my_init.d/bootstrap-db.sh  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD ["/sbin/my_init"]  

