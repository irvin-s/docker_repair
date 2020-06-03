FROM debian:stretch-slim  
LABEL maintainer="bsx <bsx+docker@0xcafec0.de>"  
  
ENV DEBIAN_FRONTEND=noninteractive LC_ALL=C  
  
RUN apt-get update \  
&& apt-get install -y prosody lua-event lua-dbi-postgresql lua-zlib \  
&& apt-get autoremove --purge \  
&& apt-get clean \  
&& mkdir /var/run/prosody \  
&& chown prosody:prosody /var/run/prosody  
  
COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua  
  
VOLUME /etc/prosody  
  
EXPOSE 80 443 5000 5269 5280-5281 5347 5222  
ENTRYPOINT ["/usr/bin/prosodyctl"]  
  
CMD ["start"]  

