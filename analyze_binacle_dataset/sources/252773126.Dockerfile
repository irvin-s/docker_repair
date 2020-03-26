FROM ruby:2.1.8  
# Install dependencies  
RUN apt-get update && \  
apt-get install -y build-essential cron supervisor gettext && \  
rm -rf /var/lib/apt/lists/*  
  
# BatsD  
RUN cd /opt && \  
git clone git://github.com/bfolkens/batsd && \  
cd batsd && \  
gem install bundler && \  
bundle install  
  
# Cleanup  
RUN rm -rf /tmp/ && apt-get clean && apt-get autoremove -y && mkdir /tmp  
  
ADD etc/config.tmpl.yml /opt/batsd/config.tmpl.yml  
ADD etc/crontab /etc/  
RUN chown root:root /etc/crontab  
ADD etc/supervisord.conf /etc/supervisord.conf  
  
ADD bin/startup.sh /usr/bin/startup.sh  
  
EXPOSE 8125/udp  
CMD ["/usr/bin/startup.sh"]  

