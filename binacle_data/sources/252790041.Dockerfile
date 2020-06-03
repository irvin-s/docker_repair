FROM camptocamp/collectd:v0.2.3  
  
MAINTAINER Marc Fournier <marc.fournier@camptocamp.com>  
  
RUN apt-get update \  
&& apt-get -y upgrade \  
&& apt-get -y --no-install-suggests --no-install-recommends install \  
libvarnishapi1 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY /collectd.conf /etc/collectd/collectd.conf.d/varnish.conf  
  

