FROM phusion/passenger-ruby19  
  
WORKDIR /home/app  
  
ENV HOME /home/app  
  
COPY . /home/app  
COPY ./config/webapp.conf /etc/nginx/sites-enabled/webapp.conf  
  
RUN bundle install && \  
chown app.app $HOME -R && \  
rm /etc/nginx/sites-enabled/default && \  
rm -f /etc/service/nginx/down && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD ["/sbin/my_init"]  

