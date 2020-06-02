FROM phusion/passenger-ruby23  
  
WORKDIR /home/app  
ENV HOME /home/app  
  
RUN apt-get update  
  
COPY . /home/app  
COPY ./config/webapp.conf /etc/nginx/sites-enabled/webapp.conf  
  
RUN mkdir -p $HOME/logs && \  
mkdir -p $HOME/tmp && \  
bundle install --without development && \  
chown app.app $HOME -R && \  
rm /etc/nginx/sites-enabled/default && \  
rm -f /etc/service/nginx/down && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD ["/sbin/my_init"]  

