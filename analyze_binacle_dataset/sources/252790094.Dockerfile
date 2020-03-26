FROM camptocamp/collectd:v5.8.0-20180504  
RUN apt-get update \  
&& apt-get -y upgrade \  
&& apt-get -y --no-install-suggests --no-install-recommends install \  
dnsutils \  
liboping0 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD ./bin/* /usr/local/bin/  
ADD ./conf.d /etc/confd/conf.d  
ADD ./templates /etc/confd/templates  
ADD ./confd.run /etc/service/confd/run  
ADD ./collectd.run /etc/service/collectd/run  
  
COPY /config/*.conf /etc/collectd/collectd.conf.d/  

