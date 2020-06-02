FROM python  
  
MAINTAINER Kerry Knopp kerry@codekoalas.com  
  
RUN apt-get update && apt-get install -y \  
cron supervisor \  
vim \  
\--no-install-recommends && rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /root/python  
# old? RUN ln -s /usr/bin/python2.7.distrib /usr/bin/python  
WORKDIR /root  
  
COPY start.sh crons.conf /root/  
COPY supervisord.conf /etc/supervisor/supervisord.conf  
  
# Add cron job  
RUN crontab /root/crons.conf  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

