FROM ubuntu:latest  
  
MAINTAINER Chris Tomich "chris.tomich@oystr.co"  
RUN apt-get update \  
&& apt-get install -y build-essential wget python \  
&& cd /tmp \  
&& wget https://nodejs.org/dist/v4.3.2/node-v4.3.2.tar.gz \  
&& mkdir node \  
&& tar xzf node-v4.3.2.tar.gz --strip-components=1 -C ./node \  
&& cd /tmp/node \  
&& ./configure \  
&& make \  
&& make install \  
&& rm -rf /tmp/* \  
&& apt-get remove -y --auto-remove build-essential wget python \  
&& apt-get install -y git supervisor nginx \  
&& apt-get autoremove -y \  
&& apt-get clean -y  
  
RUN update-rc.d -f nginx remove  
RUN rm -f /etc/nginx/nginx.conf  
  
RUN mkdir /etc/nginx/ssl  
  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
ADD nginx-default.conf /etc/nginx/nginx-default.conf  
ADD default-non-ssl /etc/nginx/sites-available/default-non-ssl  
ADD default-ssl /etc/nginx/sites-available/default-ssl  
  
VOLUME ["/etc/nginx/ssl"]  
VOLUME ["/etc/nginx/nginx.conf"]  
VOLUME ["/etc/nginx/sites-available"]  
  
WORKDIR /var/lib  
RUN npm install -g sinopia  
RUN mkdir sinopia  
RUN mkdir sinopia/storage  
  
ADD config-default.yaml /var/lib/sinopia/config-default.yaml  
  
VOLUME ["/var/lib/sinopia/htpasswd"]  
VOLUME ["/var/lib/sinopia/config.yaml"]  
VOLUME ["/var/lib/sinopia"]  
VOLUME ["/var/lib/sinopia/storage"]  
  
ADD start_supervisord.sh /start_supervisord.sh  
RUN chmod 755 /start_supervisord.sh  
  
CMD ["/start_supervisord.sh"]  
  
EXPOSE 80 443

