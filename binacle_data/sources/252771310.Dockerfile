FROM debian:jessie  
  
RUN echo "Prevent any documentation and locale from being installed by apt" \  
&& echo "path-exclude /usr/share/doc/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc \  
&& echo "path-exclude /usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc \  
&& echo "path-exclude /usr/share/info/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc \  
&& echo "path-exclude /usr/share/locale/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc  

