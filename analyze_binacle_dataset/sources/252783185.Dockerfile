FROM python  
  
RUN set -e \  
&& ln -sf /bin/bash /bin/sh  
  
RUN set -e \  
&& apt-get -y update \  
&& apt-get -y upgrade \  
&& apt-get -y autoremove \  
&& apt-get clean  
  
RUN set -e \  
&& pip install -U --no-cache-dir pip \  
&& pip install -U --no-cache-dir \  
git+https://github.com/oanda/oandapy.git \  
git+https://github.com/dceoy/fract.git  
  
ENTRYPOINT ["fract"]  

