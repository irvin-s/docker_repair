FROM stackbrew/ubuntu:13.10  
MAINTAINER Democracy Works, Inc. <dev@turbovote.org>  
  
# Let's get haproxy  
RUN apt-get update -q  
RUN apt-get install -y haproxy  
  
# Let's get serf  
RUN apt-get install -qy supervisor unzip  
ADD https://dl.bintray.com/mitchellh/serf/0.4.1_linux_amd64.zip serf.zip  
RUN unzip serf.zip  
RUN mv serf /usr/bin/  
  
ADD enabled /etc/default/haproxy  
ADD haproxy.cfg /etc/haproxy/haproxy.cfg  
ADD serf-member-join.sh /serf-member-join.sh  
ADD serf-member-leave.sh /serf-member-leave.sh  
  
ADD /start-haproxy.sh /start-haproxy.sh  
ADD /start-serf.sh /start-serf.sh  
ADD /serf-join.sh /serf-join.sh  
ADD /run.sh /run.sh  
ADD /supervisord-haproxy.conf /etc/supervisor/conf.d/supervisord-haproxy.conf  
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf  
RUN chmod 755 /*.sh  
RUN rm *.zip  
  
EXPOSE 80 8080  
CMD ["/run.sh"]  

