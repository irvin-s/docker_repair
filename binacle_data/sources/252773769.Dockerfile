# debsecan - Debian Security Analyzer  
  
FROM debian:jessie  
  
# Install debsecan and ca-certificates for SSL certificate validation:  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install --no-install-recommends --no-install-suggests -y \  
debsecan \  
ca-certificates \  
# Remove obsolete files:  
&& apt-get clean \  
&& rm -rf \  
/tmp/* \  
/usr/share/doc/* \  
/var/cache/* \  
/var/lib/apt/lists/* \  
/var/tmp/* \  
# Patch debsecan to add "stretch" (Debian 9) as target suite:  
&& sed -i "s/'jessie', /&'stretch', /" /usr/bin/debsecan  
  
ENTRYPOINT ["debsecan"]  
  
CMD [""]  

