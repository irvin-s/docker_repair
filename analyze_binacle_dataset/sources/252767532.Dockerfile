FROM ubuntu:17.04  
LABEL maintainer="Alexandre Buisine <alexandrejabuisine@gmail.com>" \  
com.prometheus.monitoring="true" \  
com.prometheus.port="9090" \  
version="1"  
  
# install python modules for monitoring  
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \  
&& apt-get install -yqq --no-install-recommends \  
python \  
python-pip \  
python-wheel \  
python-setuptools \  
&& pip install prometheus_client \  
&& pip install requests \  
&& apt-get -yqq remove --purge python-pip \  
&& apt-get -yqq autoremove --purge \  
&& apt-get -yqq clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY resources/docker-entrypoint.py \  
resources/CryptoAPICollector.py \  
/usr/local/bin/  
RUN chmod +x /usr/local/bin/docker-entrypoint.py  
  
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.py" ]  
CMD [ "--collector-port", "9090" ]

