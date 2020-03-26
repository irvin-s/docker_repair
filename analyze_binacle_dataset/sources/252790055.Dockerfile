FROM ubuntu:xenial  
  
RUN apt-get update \  
&& apt-get -y upgrade \  
&& apt-get -y --no-install-suggests --no-install-recommends install \  
runit \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN touch /etc/inittab  
  
ADD ./confd.run /etc/service/confd/run  
ADD ./haproxy_exporter.run /etc/service/haproxy_exporter/run  
  
ADD ./conf.d /etc/confd/conf.d  
ADD ./templates /etc/confd/templates  
  
ENTRYPOINT ["/usr/sbin/runsvdir-start"]  

