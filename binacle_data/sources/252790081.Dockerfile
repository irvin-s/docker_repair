FROM debian:stretch  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends gettext-base curl \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /  
  
ENV HOST_FILTER="monitoring!=\"true\"" \  
DB_FILTER=".*" \  
RESOLUTION="1m"  
CMD /install_rules.sh  

