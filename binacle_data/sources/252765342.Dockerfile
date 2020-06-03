FROM 0x6c7862/afl-fuzz:latest  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
\--no-install-suggests \  
libini-config-dev \  
&& cd /usr/local/src \  
&& git clone --depth=1 https://github.com/zardus/preeny.git \  
&& cd preeny \  
&& make dist \  
&& apt-get clean -y \  
&& rm -rf /var/lib/apt/lists/*  

