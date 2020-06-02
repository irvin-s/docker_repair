FROM dewiring/spec_cucumber:latest  
  
MAINTAINER Andreas Schmidt <andreas@de-wiring.net>  
  
RUN apt-get -yq update  
RUN apt-get -yq install \  
nginx \  
supervisor \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# supervisord starts nginx and cucumber processing loop  
ADD supervisord.conf /etc/supervisor/supervisord.conf  
  
# w/ config for serving static files  
ADD www /var/www  
  
EXPOSE 80  
ENTRYPOINT [ "/usr/bin/supervisord" ]  

